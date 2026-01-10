{ config, pkgs, inputs, ... }:

{
  services = {
    syncthing = {
      enable = true;
      user = "0x0CFF";
      guiAddress = "0.0.0.0:8384";
      dataDir = "/home/0x0CFF/Solution";
      extraFlags = [
          # "--reset-database"
      ];
    };
  };

  # 防火墙端口配置
  networking.firewall = {
    allowedTCPPorts = [
      8384                        # Web 管理后台
    ];
    allowedUDPPorts = [
      #
    ];
    allowedUDPPortRanges = [
      #
    ];
  };
}
