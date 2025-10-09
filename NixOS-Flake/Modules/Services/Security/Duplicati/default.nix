{ config, pkgs, inputs, ... }:

{
  services = {
    duplicati = {
      enable = true;
      interface = "0.0.0.0"
      port = 8200;
    };
  };
  
  # 防火墙端口配置
  networking.firewall = {
    allowedTCPPorts = [
      8200                        # Web 管理后台
    ];
    allowedUDPPorts = [
      #
    ];
    allowedUDPPortRanges = [
      #
    ];
  };
}
