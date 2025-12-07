{ config, pkgs, inputs, ... }:

{
  services = {
    home-assistant = {
      enable = true;
      openFirewall = true;    # 开放防火墙端口
    };
  };
}