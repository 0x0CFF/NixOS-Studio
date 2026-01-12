{ config, pkgs, inputs, ... }:

{
  # 在 timers 服务中启用 systemd 单元
  systemd.timers."gc-samba" = {
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
  systemd.services."gc-samba" = {
    # 运行脚本
    # 查找程序所在位置 echo $(which ssh)
    script = ''
      # 清空 SMB 回收站 .Trash 目录，包括隐藏文件
      for dir in /mnt/*/*/.Trash/; do
        # 检查目录是否存在
        if [ -d "$dir" ]; then
          # 删除 30 天前的文件（包括隐藏文件）
          find "$dir" -type f -mtime +30 -delete 2>/dev/null
          # 删除空目录（不包括 .Trash 本身）
          find "$dir" -mindepth 1 -type d -empty -delete 2>/dev/null
        fi
      done
    '';
    # 单元配置
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
