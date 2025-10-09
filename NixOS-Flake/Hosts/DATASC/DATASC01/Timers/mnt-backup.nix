{ config, pkgs, inputs, ... }:

{
  # 在 timers 服务中启用 systemd 单元
  systemd.timers."material-backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # 需要运行的单元（脚本或程序）
      Unit = "material-backup.service";
      # 在系统运行时，每周日 05：00：00 运行一次
      OnCalendar = "Sun 05:00:00";
    };
  };

  # 定义 systemd 单元
  systemd.services."material-backup" = {
    # 运行脚本
    # 查找程序所在位置 echo $(which ssh)
    script = ''
      # 镜像备份，DATASC01 [ /mnt/Archive#*/ ] --> DATABC01 [ /mnt/Archive#*/ ]
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /mnt/Archive#01 0x0CFF@192.168.31.200:/mnt/Archive#01
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /mnt/Archive#02 0x0CFF@192.168.31.200:/mnt/Archive#02
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /mnt/Archive#03 0x0CFF@192.168.31.200:/mnt/Archive#03
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /mnt/Archive#04 0x0CFF@192.168.31.200:/mnt/Archive#04
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /mnt/Archive#05 0x0CFF@192.168.31.200:/mnt/Archive#05
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /mnt/Archive#06 0x0CFF@192.168.31.200:/mnt/Archive#06
    '';
    # 单元配置
    serviceConfig = {
      Type = "oneshot";
      User = "0x0CFF";
    };
  };
}
