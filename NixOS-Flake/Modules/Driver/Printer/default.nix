{ config, lib, pkgs, ... }:

{
  services = {
    # 启用 CUPS 以打印文档
    printing = {
      enable = true;
    };
  };
}