{ config, pkgs, inputs, ... }:

{
  # 在 timers 服务中启用 systemd 单元
  systemd.timers."mount-point-gc" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # 在系统运行时，每年 1 月 1 日开始，每 2 个月循环，在 05：00：00 运行任务
      OnCalendar = "*-01/2-01 05:00:00";
      # 如果服务在执行时间内由于意外没有触发，则立即补执行
      Persistent = true;
    };
  };

  # 定义 systemd 单元
  systemd.services."mount-point-gc" = {
    # 运行脚本
    # 查找程序所在位置 echo $(which ssh)
    script = ''
      # 清空挂载点垃圾箱
      find /mnt -type d -name ".Trash-0" -exec sh -c 'rm -rf "$1"/* "$1"/.* 2>/dev/null || true' _ {} \;
    '';
    # 单元配置
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
