{ config, pkgs, inputs, ... }:

{
  # 在 timers 服务中启用 systemd 单元
  systemd.timers."gc-mount-point" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # 在系统运行时，每年 1 月 1 日开始，每 2 个月循环，在 05：00：00 运行任务
      OnCalendar = "*-*-* 06:00:00";
      # 如果服务在执行时间内由于意外没有触发，则立即补执行
      Persistent = true;
      # 随机延迟执行，避免多个任务同时启动
      RandomizedDelaySec = "5min";
    };
  };

  # 定义 systemd 单元
  systemd.services."gc-mount-point" = {
    # 运行脚本
    # 查找程序所在位置 echo $(which ssh)
    script = ''
      # 清理挂载点回收站中 30 天前的空目录和文件（包括隐藏文件）
      find /mnt -type d -name ".Trash-0" -exec sh -c '
        find "$1" -type f -mtime +30 -delete 2>/dev/null;
        find "$1" -mindepth 1 -type d -empty -delete 2>/dev/null
      ' _ {} \;
    '';
    # 单元配置
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
