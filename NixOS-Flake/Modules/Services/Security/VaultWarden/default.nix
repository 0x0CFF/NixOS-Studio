{ config, pkgs, inputs, ... }:

let
  # 您的服务器 IP 地址
  serverIp = "192.168.31.96";

  # SSL 证书路径
  sslDir = "/home/0x0CFF/Solution/Blueprints/NixOS/NixOS-Studio/NixOS-Flake/Modules/Services/Security/VaultWarden/Dotfiles";
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
      # 开启 WebSocket 支持
      enableWebsocket = true;
      # 数据库配置（sqlite、postgresql）
      dbBackend = "sqlite";
      # 环境变量文件（用于敏感信息）
      environmentFile = "/var/lib/private/vaultwarden/.env";
      config = {
        # 域名设置，使用 IP 地址作为域名
        DOMAIN = "https://${serverIp}";
        # 开启管理员页面
        ADMIN_TOKEN = "U6b74hfy+";
        # 数据库配置
        DATABASE_URL = "data/db.sqlite3";
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
        # 数据保留设置
        DATA_FOLDER = "/var/lib/private/vaultwarden";
        # 其他安全设置
        # SHOW_PASSWORD_HINT = false;
        PASSWORD_ITERATIONS = 100000;       # 增加密码迭代次数提高安全性
        SIGNUPS_ALLOWED = false;            # 是否允许注册，生产环境建议关闭注册
      };
    };
    # 配置 Nginx 反向代理和 SSL
    nginx = {
      enable = true;
      # 推荐的安全设置
      recommendedTlsSettings = true;
      recommendedOptimisation = true;
      recommendedGzipSettings = true;
      recommendedProxySettings = true;
      # 虚拟主机配置
      virtualHosts."${serverIp}" = {
        forceSSL = true;
        enableACME = false;  # 不使用 Let's Encrypt，使用自定义证书
        # 使用 mkcert 生成的证书
        sslCertificate = certFile;
        sslCertificateKey = keyFile;
        # / 路径
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
          proxyWebsockets = true;  # 支持 WebSocket
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Host $host;
            proxy_set_header X-Forwarded-Port $server_port;

            # 超时设置
            proxy_connect_timeout 60s;
            proxy_send_timeout 60s;
            proxy_read_timeout 60s;
          '';
        };
        # WebSocket 路径
        locations."/notifications/hub" = {
          proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.WEBSOCKET_PORT}";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          '';
        };
        # WebSocket 协商
        locations."/notifications/hub/negotiate" = {
          proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          '';
        };
        # 安全头
        extraConfig = ''
          # 安全头
          add_header X-Frame-Options "SAMEORIGIN" always;
          add_header X-Content-Type-Options "nosniff" always;
          add_header X-XSS-Protection "1; mode=block" always;
          add_header Referrer-Policy "strict-origin-when-cross-origin" always;

          # HSTS (HTTPS Strict Transport Security)
          add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
        '';
      };
    }
  };

  # 设置证书和权限
  systemd.services.vaultwarden-setup = {
    description = "Setup Vaultwarden SSL certificates";
    wantedBy = [ "vaultwarden.service" ];
    before = [ "vaultwarden.service" "nginx.service" ];
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
      mkdir -p /var/lib/private/vaultwarden

      # 设置目录权限
      chmod 700 ${sslDir}
      chmod 700 /var/lib/private/vaultwarden

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
      chmod 600 ${certFile} ${keyFile}
      chown nginx:nginx ${certFile} ${keyFile}

      # 创建环境文件（如果不存在）
      if [ ! -f /var/lib/private/vaultwarden/.env ]; then
        cat > /var/lib/private/vaultwarden/.env << EOF
      # Vaultwarden 环境变量
      # ADMIN_TOKEN 已经在配置中设置
      # 可以在这里添加其他敏感变量
      EOF
        chmod 600 /var/lib/private/vaultwarden/.env
        chown vaultwarden:vaultwarden /var/lib/private/vaultwarden/.env
      fi
    '';
  };

  # 备份配置（可选）
  services.vaultwarden.backup = {
    enable = true;
    interval = "daily";
    location = "/var/lib/private/vaultwarden/backups";
  };
  
  # 系统服务依赖
  systemd.services.nginx.after = [ "vaultwarden-setup.service" ];
  systemd.services.vaultwarden.after = [ "vaultwarden-setup.service" ];

  # 持久化配置
  systemd.tmpfiles.rules = [
    "d /var/lib/private/vaultwarden 0750 vaultwarden vaultwarden -"
    "d /var/lib/private/vaultwarden/backups 0750 vaultwarden vaultwarden -"
    "d ${sslDir} 0750 nginx nginx -"
  ];

  # 防火墙端口配置
  networking.firewall = {
    allowedTCPPorts = [
      80                          # HTTP
      443                         # HTTPS
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
