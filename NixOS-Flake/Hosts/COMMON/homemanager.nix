{ config, lib, pkgs, inputs, ... }:

{
  # 启用 Home Manager 并自引用
  programs.home-manager.enable = true;
  home = {
    username = "0x0CFF";
    homeDirectory = "/home/0x0CFF";
    stateVersion = "25.11";
  };

  # 用户环境变量
  # home.sessionVariables = {
  # };

  # 用户软件
  # home.packages = with pkgs; [
  #   glib
  # ];
}
