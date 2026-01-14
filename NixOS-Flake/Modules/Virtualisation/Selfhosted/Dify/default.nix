{ config, pkgs, inputs, ... }:

{
  # 配置 agenix：定义加密的 secret 及其解密后的路径
  age.secrets.dify_env = {
    # 加密文件相对于 Nix 配置目录的路径
    file = ./Dotfiles/dify.env.age;
    # 解密后文件在系统中的路径（推荐放在 /run/agenix）
    path = "/run/agenix/dify.env";
    # 设置解密后文件的权限（例如，对服务用户可读）
    owner = "root";
    group = "root";
    mode = "0440";
  };

  # 定义 systemd 服务
  systemd.services.dify = {
    description = "Dify AI Service";
    after = [ "network.target" "docker.service" "agenix-dify_env.service" ]; # 确保解密完成
    requires = [ "docker.service" "agenix-dify_env.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "exec";
      # 设置工作目录（Dify docker-compose 项目目录）
      WorkingDirectory = /home/0x0CFF/Solution/Selfhosted/dify/docker;
      # 通过 EnvironmentFile 加载解密后的环境变量[citation:5][citation:8]
      EnvironmentFile = config.age.secrets.dify_env.path; # 指向 /run/agenix/dify.env
      # 启动命令
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose up";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose down";
      Restart = "on-failure";
      RestartSec = "10s";
    };

    # 设置环境变量
    environment = {
      COMPOSE_FILE = /home/0x0CFF/Solution/Selfhosted/dify/docker/docker-compose.yml;
      EXPOSE_NGINX_PORT=9000
      EXPOSE_NGINX_SSL_PORT=9001
      # 其他非敏感变量
    };
  };
  
  # 防火墙端口配置
  networking.firewall = {
    allowedTCPPorts = [
      9000                     # HTTP 端口
      9001                     # HTTPS 端口
    ];
    allowedUDPPorts = [
      #
    ];
    allowedUDPPortRanges = [
      #
    ];
  };
}
