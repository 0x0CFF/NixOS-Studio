{ config, pkgs, inputs, ... }:

let
  # 服务器 IP 地址
  serverIp = "192.168.31.96";
  # SSL 证书路径
  sslDir = "/var/lib/vaultwarden";
  certFile = "${sslDir}/vaultwarden-cert.pem";
  keyFile = "${sslDir}/vaultwarden-key.pem";
in
{
  # 安装 openssl
  environment.systemPackages = with pkgs; [
    mkcert                   # [CLI] [GO] 本地信任开发证书工具
  ];

  services = {
    vaultwarden = {
      enable = true;
      # 数据库配置（sqlite、mySQL、postgresql）
      dbBackend = "sqlite";
      # backupDir = "/var/backup/vaultwarden";
      # 环境变量文件（用于敏感信息）
      environmentFile = "/var/lib/vaultwarden/vaultwarden.env";
      config = {
        # 域名设置，使用 IP 地址作为域名
        DOMAIN = "https://${serverIp}";
        # 开启管理员页面，设置完成后可通过 /admin 子目录访问管理页面
        ADMIN_TOKEN = "U6b74hfy+";
        # Rocket 服务器配置
        ROCKET_ADDRESS = "0.0.0.0";
        ROCKET_PORT = 8222;
        # WebSocket 配置（用于实时同步）
        WEBSOCKET_ENABLED = true;
        WEBSOCKET_ADDRESS = "0.0.0.0";
        WEBSOCKET_PORT = 3012;
        # 邮件设置（可选）
        # SMTP_HOST = "smtp.example.com";
        # SMTP_FROM = "vaultwarden@studio.com";
        # SMTP_PORT = 587;
        # SMTP_SSL = true;
        # SMTP_USERNAME = "username";
        # SMTP_PASSWORD = "password";
        # 日志级别
        LOG_LEVEL = "warn";
        EXTENDED_LOGGING = false;
        # 其他安全设置
        # SHOW_PASSWORD_HINT = false;
        PASSWORD_ITERATIONS = 100000;       # 增加密码迭代次数提高安全性
        SIGNUPS_ALLOWED = false;            # 是否允许注册，生产环境建议关闭注册
      };
    };
  };

  # 设置证书和权限
  systemd.services.vaultwarden-setup = {
    description = "Setup Vaultwarden SSL certificates";
    wantedBy = [ "vaultwarden.service" ];
    before = [ "vaultwarden.service" ];
    after = [ "network.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      User = "root";
    };

    path = with pkgs; [ coreutils ];

    script = ''
      # 创建必要的目录
      mkdir -p ${sslDir}
      # 设置目录权限
      chown vaultwarden:vaultwarden ${sslDir}
      chmod 700 ${sslDir}

      # 如果证书文件不存在，生成它们
      if [ ! -f ${certFile} ] || [ ! -f ${keyFile} ]; then
        echo "Generating SSL certificates with mkcert..."

        # 临时进入目录
        cd ${sslDir}

        # 使用 nix-shell 中的 mkcert
        ${pkgs.mkcert}/bin/mkcert \
          -cert-file vaultwarden-cert.pem \
          -key-file vaultwarden-key.pem \
          ${serverIp} localhost 127.0.0.1 ::1

        echo "Certificates generated successfully."
      fi

      # 设置证书权限
      chown vaultwarden:vaultwarden ${certFile} ${keyFile}
      chmod 700 ${certFile} ${keyFile}
      
      # 创建环境文件（如果不存在）
      if [ ! -f /var/lib/vaultwarden/vaultwarden.env ]; then
        cat > /var/lib/vaultwarden/vaultwarden.env << EOF
      # Vaultwarden 环境变量，可以在这里添加其他敏感变量
      ROCKET_TLS={certs="/var/lib/vaultwarden/vaultwarden-cert.pem",key="/var/lib/vaultwarden/vaultwarden-key.pem"}
      EOF
        chmod 600 /var/lib/vaultwarden/vaultwarden.env
        chown vaultwarden:vaultwarden /var/lib/vaultwarden/vaultwarden.env
      fi
    '';
  };

  # 防火墙端口配置
  networking.firewall = {
    allowedTCPPorts = [
      8222                        # Rocket 服务
      3012                        # WebSocket 服务
    ];
    allowedUDPPorts = [
      #
    ];
    allowedUDPPortRanges = [
      #
    ];
  };
}
