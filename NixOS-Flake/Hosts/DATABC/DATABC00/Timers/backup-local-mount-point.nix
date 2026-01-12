{ config, pkgs, inputs, ... }:

{
  # 在 timers 服务中启用 systemd 单元
  systemd.timers."backup-local-mount-point" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # 每天 08:00 到 20:00 之间，每 2 个小时运行一次
      OnCalendar = "*-*-* 08..20:00:00/2";
      # 如果服务在执行时间内由于意外没有触发，则立即补执行
      Persistent = true;
    };
  };

  # 定义 systemd 单元
  systemd.services."backup-local-mount-point" = {
    # 运行脚本
    # 查找程序所在位置 echo $(which ssh)
    script = ''
      # Rsync 参数说明
      # -a：归档模式，保留文件权限、时间戳、符号链接等元数据
      # -v：详细模式，显示传输过程中的详细信息
      # -p：保留文件权限
      # -X：在归档模式基础上，额外保留扩展属性（例如 chattr 修改后的属性）

      # 镜像备份，DATABC00 [ /mnt/Temp/ ] --> DATABC00-BACKUP [ /mnt/Temp/ ]
      ${pkgs.rsync}/bin/rsync -avPX --delete -e "/run/current-system/sw/bin/ssh" /mnt/Temp/ 0x0CFF@192.168.31.101:/mnt/Temp/
      # 镜像备份，DATABC00 [ /mnt/Workspace/ ] --> DATABC00-BACKUP [ /mnt/Workspace/ ]
      ${pkgs.rsync}/bin/rsync -avPX --delete -e "/run/current-system/sw/bin/ssh" /mnt/Workspace/ 0x0CFF@192.168.31.101:/mnt/Workspace/
      # 镜像备份，DATABC00 [ /mnt/Document/ ] --> DATABC00-BACKUP [ /mnt/Document/ ]
      ${pkgs.rsync}/bin/rsync -avPX --delete -e "/run/current-system/sw/bin/ssh" /mnt/Document/ 0x0CFF@192.168.31.101:/mnt/Document/
    '';
    # 单元配置
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
