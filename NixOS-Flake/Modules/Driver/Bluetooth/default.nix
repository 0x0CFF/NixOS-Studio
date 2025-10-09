{ config, lib, pkgs, ... }:

{
  hardware = {
    # 启用蓝牙
    bluetooth = {
      enable = true;         # 启用对蓝牙的支持
      powerOnBoot = true;    # 系统启动时启动蓝牙控制器
    };
  };
}
