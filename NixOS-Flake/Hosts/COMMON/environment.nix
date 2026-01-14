{ config, lib, pkgs, ... }:

{
  # 系统环境变量
  environment.variables = {
    EDITOR = "hx";                # 系统默认编辑器
    # NIXPKGS_ALLOW_BROKEN = 1;     # 允许系统使用破损包
  };
}