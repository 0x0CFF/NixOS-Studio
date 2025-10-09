{ config, pkgs, inputs, ... }:

{
  # 在 timers 服务中启用 systemd 单元
  systemd.timers."workspace-backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # 需要运行的单元（脚本或程序）
      Unit = "workspace-backup.service";
      # 每 15 分钟运行一次
      OnUnitActiveSec = "15min";
    };
  };

  # 定义 systemd 单元
  systemd.services."workspace-backup" = {
    # 运行脚本
    # 查找程序所在位置 echo $(which ssh)
    script = ''
      # 镜像备份，NODENS01 [ /home/0x0CFF/Solution/Data/Obsidan/ ] --> NODENS00 [ /home/0x0CFF/Solution/Data/Obsidan/ ]
      ${pkgs.rsync}/bin/rsync -avP --delete -e "/run/current-system/sw/bin/ssh" /home/0x0CFF/Solution/Data/Obsidan/ 0x0CFF@192.168.31.200:/home/0x0CFF/Solution/Data/Obsidan/
    '';
    # 单元配置
    serviceConfig = {
      Type = "oneshot";
      User = "0x0CFF";
    };
  };
}