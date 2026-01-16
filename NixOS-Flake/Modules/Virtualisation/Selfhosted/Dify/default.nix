{ config, pkgs, inputs, ... }:

let
  difyDir = "/opt/Dify";
  
  # 现有 docker-compose.yaml 文件
  baseComposeFile = /home/0x0CFF/Solution/Selfhosted/Dify/docker/docker-compose.yaml;
  # 覆写 docker-compose.yaml 文件中的，如果原始文件已有定义，会合并
  modifiedComposeFile = pkgs.writeText "docker-compose.yaml" ''
    ${baseComposeFile}
    
    x-shared-env: &shared-api-worker-env
      # 添加 PIP 境内源
      PIP_INDEX_URL: ${PIP_INDEX_URL:-https://pypi.tuna.tsinghua.edu.cn/simple}
      PIP_TRUSTED_HOST: ${PIP_TRUSTED_HOST:-pypi.tuna.tsinghua.edu.cn}
      
    plugin_daemon:
      environment:
        PIP_TRUSTED_HOST: $PIP_TRUSTED_HOST
        PIP_INDEX_URL: $PIP_INDEX_URL
  '';
  
  # 从现有 .env.example 文件读取环境变量，并注入 Nix 变量
  baseEnvContent = builtins.readFile /home/0x0CFF/Solution/Selfhosted/Dify/docker/.env.example;
  # 覆写 baseEnvContent 环境变量中的值，敏感数据使用 agenix 模块加载
  generatedEnv = pkgs.writeText "dify.env" ''
    ${baseEnvContent}
    
    EXPOSE_NGINX_PORT=9000
    LOG_LEVEL=WARNNING
    PIP_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple
    PIP_TRUSTED_HOST=pypi.tuna.tsinghua.edu.cn
    LOG_TZ=${config.time.timeZone}
    DB_PASSWORD=${builtins.readFile config.age.secrets.dify-db-password.path}
    REDIS_PASSWORD=${builtins.readFile config.age.secrets.dify-redis-password.path}
  '';
  
  # 代理配置
  proxyConfig = {
    httpProxy = "http://192.168.31.96:20172";    # HTTP 代理
    httpsProxy = "http://192.168.31.96:20172";   # HTTPS 代理
    noProxy = "localhost,127.0.0.1,.local";      # 绕过代理的地址
  };

  # 启动脚本，包含代理设置
  startScript = pkgs.writeShellScript "dify-start-with-proxy" ''
    set -e
    
    cd ${difyDir}
    # 设置当前 shell 的环境变量，开启临时代理
    export http_proxy="${proxyConfig.httpProxy}"
    export HTTP_PROXY="${proxyConfig.httpProxy}"
    export https_proxy="${proxyConfig.httpsProxy}"
    export HTTPS_PROXY="${proxyConfig.httpsProxy}"
    export no_proxy="${proxyConfig.noProxy}"
    export NO_PROXY="${proxyConfig.noProxy}"
    
    # 测试代理连接
    if curl --max-time 10 --proxy "$HTTP_PROXY" https://api.openai.com/v1/models 2>/dev/null | grep -q "object"; then
      echo "代理连接测试成功"
    else
      echo "代理连接测试失败，但继续执行"
    fi
    
    # 启动 docker-compose，指定使用 .env 文件
    # 环境变量会传递给子进程
    ${pkgs.docker-compose}/bin/docker-compose --env-file .env up -d
    
    # 清理代理环境变量
    sleep 3
    unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY no_proxy NO_PROXY
  '';
  
  # 停止脚本
  stopScript = pkgs.writeShellScript "dify-stop" ''
    cd ${difyDir}
    ${pkgs.docker-compose}/bin/docker-compose --env-file .env down
  '';
in
{
  # 配置 agenix：加解密敏感信息，[secret-name.age] 解密后的信息存储在 /run/agenix/[secret-name] 文件中
  age.secrets = {
    dify-db-password = {
      # 加密文件相对于当前 Nix 配置文件的路径
      file = ./Dotfiles/db-password.age;
      # 设置解密后文件的权限（例如，对服务用户可读）
      owner = "root";
      group = "root";
      mode = "0400";
    };
    dify-redis-password = {+
      # 加密文件相对于当前 Nix 配置文件的路径
      file = ./Dotfiles/redis-password.age;
      # 设置解密后文件的权限（例如，对服务用户可读）
      owner = "root";
      group = "root";
      mode = "0400";
    };
    # openai-api-key = {
    #   # 加密文件相对于当前 Nix 配置文件的路径
    #   file = ./Dotfiles/openai-api-key.age;
    #   # 设置解密后文件的权限（例如，对服务用户可读）
    #   owner = "root";
    #   group = "root";
    #   mode = "0400";
    # };
  };
  
  # 定义 systemd 服务
  systemd.services.dify = {
    description = "Dify AI Service";
    after = [ "network.target" "docker.service" "agenix-dify_env.service" ]; # 确保解密完成
    requires = [ "docker.service" "agenix-dify_env.service" ];
    wantedBy = [ "multi-user.target" ];

    preStart = ''
      mkdir -p ${difyDir}
      # 生成最终 docker-compose.yaml 文件
      cp ${modifiedComposeFile} ${difyDir}/docker-compose.yaml
      # 生成最终 .env 文件
      cp ${generatedEnv} ${difyDir}/.env
      chmod 600 ${difyDir}/.env
    '';
    
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      # 设置工作目录（Dify docker-compose 项目目录）
      WorkingDirectory = difyDir;
      
      # 启动命令
      ExecStart = startScript;
      ExecStop = stopScript;
      
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };
  
  # 防火墙端口配置
  networking.firewall = {
    allowedTCPPorts = [
      9000                     # Web 端口
    ];
    allowedUDPPorts = [
      #
    ];
    allowedUDPPortRanges = [
      #
    ];
  };
}
