{ config, pkgs, inputs, ... }:

{
  # 在 timers 服务中启用 systemd 单元
  systemd.timers."samba-gc" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # 在系统运行时，每年 1 月 1 日开始，每 2 个月循环，在 05：00：00 运行任务
      OnCalendar = "*-01/2-01 05:00:00";
      # 如果服务在执行时间内由于意外没有触发，则立即补执行
      Persistent = true;
    };
  };

  # 定义 systemd 单元
  systemd.services."samba-gc" = {
    # 运行脚本
    # 查找程序所在位置 echo $(which ssh)
    script = ''
      # 清空 SMB 回收站 .Trash 目录，包括隐藏文件
      for dir in /mnt/*/*/.Trash/; do
        [ -d "$dir" ] && rm -rf "$dir"/* "$dir"/.* 2>/dev/null || true
      done
    '';
    # 单元配置
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
