{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    hdparm                   # [CLI] [C] 硬盘工具
    udisks                   # [CLI] [C] 移动设备挂载工具
    # clinfo                   # [CLI] [C] OpenCL 验证工具
    # brightnessctl            # [CLI] [C] 屏幕亮度调节工具
    smartmontools            # [CLI] [C++] 硬盘健康监测工具
    kbt                      # [TUI] [RUST] 键盘按键测试工具
    bluetui                  # [TUI] [RUST] 蓝牙管理器
    # amdgpu_top               # [TUI] [RUST] AMD 显卡监视器
  ];
}
