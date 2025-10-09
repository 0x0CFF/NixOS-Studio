{ config, lib, pkgs, ... }:

{
  services = {
    # 启用触摸板支持（在大多数桌面管理器中默认启用）
    libinput = {
      enable = true;
    }
  };
}