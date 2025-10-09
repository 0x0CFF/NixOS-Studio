{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    ffmpeg                   # [CLI] [C] 视频处理工具
    imagemagick              # [CLI] [C] 图片处理工具
    gifski                   # [CLI] [RUST] GIF 编码器
  ];
}
