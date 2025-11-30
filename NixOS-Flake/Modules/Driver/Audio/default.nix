{ config, lib, pkgs, ... }:

{
  services = {
    # 启用声音（pulseaudio 与 pipewire 服务互斥，仅选择以下选项之一）
    pulseaudio = {
      enable = true;
    };
    # pipewire = {
    #   enable = true;
    #   pulse.enable = true;
    # };
  };
}