{ config, lib, pkgs, ... }:

{
  services = {
    # X 图形显示服务器
    xserver = {
      enable = true;
      xkb.layout = "us";                       # X11 键盘布局
      xkb.options = "eurosign:e,caps:escape";  # X11 键盘映射
    };
  };
}