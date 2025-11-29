{ config, pkgs, inputs, ... }:

{
  # 在 timers 服务中启用 systemd 单元
  systemd.timers."mnt-backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # 需要运行的单元（脚本或程序）
      Unit = "mnt-backup.service";
      # 在系统运行时，每年每月的 1、15 日 05：00：00 运行一次
      OnCalendar = "*-*-01,15 05:00:00";
    };
  };

  # 定义 systemd 单元
  systemd.services."mnt-backup" = {
    # 运行脚本
    # 查找程序所在位置 echo $(which ssh)
    script = ''
      # 镜像备份，DATASC00 [ /mnt/Material#*/ ] --> DATASC00-BACKUP [ /mnt/Material#*/ ]
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /mnt/Material#ANIMATION 0x0CFF@192.168.31.121:/mnt/Material#ANIMATION
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /mnt/Material#BUSINESS 0x0CFF@192.168.31.121:/mnt/Material#BUSINESS
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /mnt/Material#DESIGN 0x0CFF@192.168.31.121:/mnt/Material#DESIGN
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /mnt/Material#FINANCE 0x0CFF@192.168.31.121:/mnt/Material#FINANCE
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /mnt/Material#PUBLIC 0x0CFF@192.168.31.121:/mnt/Material#PUBLIC
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /mnt/Material#VIDEO 0x0CFF@192.168.31.121:/mnt/Material#VIDEO
    '';
    # 单元配置
    serviceConfig = {
      Type = "oneshot";
      User = "0x0CFF";
    };
  };
}
