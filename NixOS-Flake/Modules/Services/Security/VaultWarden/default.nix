{ config, pkgs, inputs, ... }:

{
  services = {
    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://bitwarden.example.com";
        SIGNUPS_ALLOWED = false;
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
        # 邮件服务配置
        # SMTP_HOST = "127.0.0.1";
        # SMTP_PORT = 25;
        # SMTP_SSL = false;
        # SMTP_FROM = "admin@bitwarden.example.com";
        # SMTP_FROM_NAME = "example.com Bitwarden server";
      };
    };
    # 反向代理
    nginx.virtualHosts."bitwarden.example.com" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
      };
    };
  };
}