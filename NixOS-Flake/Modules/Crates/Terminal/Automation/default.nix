{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    watchexec                # [AUX] [RUST] 文件改动监视工具
  ];
}
