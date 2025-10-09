{ config, pkgs, inputs, ... }:

{
  services = {
    adguardhome = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      port = 3000;
    };
  };

  # 防火墙端口配置
  networking.firewall = {
    allowedTCPPorts = [
      3000                     # Web 管理后台
      53                       # 规则代理端口
    ];
    allowedUDPPorts = [
      53                       # 规则代理端口
    ];
    allowedUDPPortRanges = [
      #
    ];
  };
}
