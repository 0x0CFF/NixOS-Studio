{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    mpv                      # [GUI] 视频浏览器
    loupe                    # [GUI] 图片浏览器
    firefox                  # [GUI] 网络浏览器
  ];
}
