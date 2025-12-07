{ config, pkgs, inputs, ... }:

{
  services = {
    adguardhome = {
      enable = true;
      openFirewall = true;     # 开放防火墙端口
      host = "0.0.0.0";
      port = 3000;
    };
  };

  # 防火墙端口配置
  networking.firewall = {
    allowedTCPPorts = [
      53                       # DNS 服务器端口
    ];
    allowedUDPPorts = [
      53                       # DNS 服务器端口
    ];
    allowedUDPPortRanges = [
      #
    ];
  };
}
