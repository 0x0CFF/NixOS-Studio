{ config, pkgs, inputs, ... }:

{
  services = {
    vaultwarden = {
      enable = true;
      # 开启 WebSocket 支持
      enableWebsocket = true;
      # 数据库备份（可选）
      # backupDir = "/var/lib/vaultwarden/backups";
      config = {
        # 域名设置
        DOMAIN = "https://vaultwarden.studio.com";
        # 开启管理员页面
        ADMIN_TOKEN = "U6b74hfy+";
        # 数据库配置
        DATABASE_URL = "data/db.sqlite3";
        # 其他配置
        SIGNUPS_ALLOWED = false;            # 是否允许注册
        ROCKET_ADDRESS = "0.0.0.0";
        ROCKET_PORT = 8222;
        # WebSocket 设置（用于实时同步）
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
      };
    };
    # 配置 Nginx 反向代理和 SSL
    nginx = {
      enable = true;
      virtualHosts."vaultwarden.studio.com" = {
        forceSSL = true;
        enableACME = false;  # 不使用 Let's Encrypt，使用自定义证书
        # 使用 mkcert 生成的证书
        sslCertificate = "/home/0x0CFF/Solution/Blueprints/NixOS/NixOS-Studio/NixOS-Flake/Modules/Services/Security/VaultWarden/Dotfiles/vaultwarden.studio.com.pem";
        sslCertificateKey = "/home/0x0CFF/Solution/Blueprints/NixOS/NixOS-Studio/NixOS-Flake/Modules/Services/Security/VaultWarden/Dotfiles/vaultwarden.studio.com-key.pem";
        # / 路径
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
          proxyWebsockets = true;  # 支持 WebSocket
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
          '';
        };
        # WebSocket 路径
        locations."/notifications/hub" = {
          proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.WEBSOCKET_PORT}";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
          '';
        };
        # WebSocket 协商
        locations."/notifications/hub/negotiate" = {
          proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
          '';
        };
      };
    }
  };
  # 持久化数据目录
  systemd.services.vaultwarden = {
    after = [ "network.target" ];
    wants = [ "network.target" ];
    
    serviceConfig = {
      StateDirectory = "vaultwarden";
      StateDirectoryMode = "0700";
      
      # 设置证书文件权限
      ExecStartPre = "${pkgs.coreutils}/bin/chmod 600 /home/0x0CFF/Solution/Blueprints/NixOS/NixOS-Studio/NixOS-Flake/Modules/Services/Security/VaultWarden/Dotfiles/*.pem";
    };
  };
  # 防火墙端口配置
  networking.firewall = {
    allowedTCPPorts = [
      80                          # HTTP
      443                         # HTTPS
    ];
    allowedUDPPorts = [
      #
    ];
    allowedUDPPortRanges = [
      #
    ];
  };
}