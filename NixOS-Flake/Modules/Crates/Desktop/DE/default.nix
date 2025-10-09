{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty                # [GUI] [RUST] 终端仿真器
    hyprland                 # [GUI] [C++] Wayland 合成器
    ags                      # [GUI] [TypeScript] Wayland 部件外壳框架
  ];
}
