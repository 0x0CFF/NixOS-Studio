{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    darktable                # [GUI] [C] 摄影后期软件
    blender                  # [GUI] [C++] 3D 建模软件
    krita                    # [GUI] [C++] 数字绘画软件
    gyroflow                 # [GUI] [RUST] 陀螺仪视频稳定工具
    zed-editor               # [GUI] [RUST] 代码编辑器
  ];
}
