{ config, pkgs, inputs, ... }:

{
  # 在 timers 服务中启用 systemd 单元
  systemd.timers."samba-gc" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # 需要运行的单元（脚本或程序）
      Unit = "samba-gc.service";
      # 在系统运行时，每年 1、3、5、7、9、11 月的 1 日 05：00：00 运行一次
      OnCalendar = "*-01,03,05,07,09,11-01 05:00:00";
    };
  };

  # 定义 systemd 单元
  systemd.services."samba-gc" = {
    # 运行脚本
    # 查找程序所在位置 echo $(which ssh)
    script = ''
      # 清空归档盘回收站
      rm -f /mnt/Archive#01/.Trash/*
      rm -f /mnt/Archive#02/.Trash/*
      rm -f /mnt/Archive#03/.Trash/*
      rm -f /mnt/Archive#04/.Trash/*
      rm -f /mnt/Archive#05/.Trash/*
      rm -f /mnt/Archive#06/.Trash/*
    '';
    # 单元配置
    serviceConfig = {
      Type = "oneshot";
      User = "0x0CFF";
    };
  };
}
