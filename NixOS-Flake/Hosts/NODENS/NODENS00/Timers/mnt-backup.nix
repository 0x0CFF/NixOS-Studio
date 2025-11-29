{ config, pkgs, inputs, ... }:

{
  # 在 timers 服务中启用 systemd 单元
  systemd.timers."mnt-backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # 需要运行的单元（脚本或程序）
      Unit = "mnt-backup.service";
      # 每 15 分钟运行一次
      OnUnitActiveSec = "15min";
    };
  };

  # 定义 systemd 单元
  systemd.services."mnt-backup" = {
    # 运行脚本
    # 查找程序所在位置 echo $(which ssh)
    script = ''
      # 镜像备份，NODENS00 [ /mnt/Temp/ ] --> NODENS00-BACKUP [ /mnt/Temp/ ]
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /mnt/Temp/ 0x0CFF@192.168.31.101:/mnt/Temp/
      # 镜像备份，NODENS00 [ /mnt/Workspace/ ] --> NODENS00-BACKUP [ /mnt/Workspace/ ]
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /mnt/Workspace/ 0x0CFF@192.168.31.101:/mnt/Workspace/
      # 镜像备份，NODENS00 [ /mnt/Document/ ] --> NODENS00-BACKUP [ /mnt/Document/ ]
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /mnt/Document/ 0x0CFF@192.168.31.101:/mnt/Document/
    '';
    # 单元配置
    serviceConfig = {
      Type = "oneshot";
      User = "0x0CFF";
    };
  };
}
