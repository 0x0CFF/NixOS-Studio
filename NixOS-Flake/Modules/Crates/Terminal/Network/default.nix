{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    speedtest-rs             # [CLI] [RUST] 互联网测速工具
    somo                     # [TUI] [RUST] 端口查看工具
    rclone                   # [CLI] [GO] 云存储文件管理工具
  ];
}