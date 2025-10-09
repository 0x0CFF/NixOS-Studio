{ config, pkgs, inputs, ... }:

{
  services = {
    v2raya = {
      enable = true;
    };
  };

  # 防火墙端口配置
  networking.firewall = {
    allowedTCPPorts = [
      2017                        # Web 管理后台
      # 20171                       # V2raya 流量端口（不分流）
      20172                       # V2raya 流量端口（分流）
    ];
    allowedUDPPorts = [
      #
    ];
    allowedUDPPortRanges = [
      #
    ];
  };
}