{ config, pkgs, inputs, ... }:

{
  # 在 timers 服务中启用 systemd 单元
  systemd.timers."backup-local-mount-point" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # 在系统运行时，每月 1 日开始，每 3 天循环，在 05:00:00 运行任务
      OnCalendar = "*-*-01/3 05:00:00";
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

      # 镜像备份，DATASC00 [ /mnt/Material#*/ ] --> DATASC00-BACKUP [ /mnt/Material#*/ ]
      ${pkgs.rsync}/bin/rsync -avPX --delete -e "/run/current-system/sw/bin/ssh" /mnt/Material#ANIMATION 0x0CFF@192.168.31.121:/mnt/Material#ANIMATION
      ${pkgs.rsync}/bin/rsync -avPX --delete -e "/run/current-system/sw/bin/ssh" /mnt/Material#BUSINESS 0x0CFF@192.168.31.121:/mnt/Material#BUSINESS
      ${pkgs.rsync}/bin/rsync -avPX --delete -e "/run/current-system/sw/bin/ssh" /mnt/Material#DESIGN 0x0CFF@192.168.31.121:/mnt/Material#DESIGN
      ${pkgs.rsync}/bin/rsync -avPX --delete -e "/run/current-system/sw/bin/ssh" /mnt/Material#FINANCE 0x0CFF@192.168.31.121:/mnt/Material#FINANCE
      ${pkgs.rsync}/bin/rsync -avPX --delete -e "/run/current-system/sw/bin/ssh" /mnt/Material#PUBLIC 0x0CFF@192.168.31.121:/mnt/Material#PUBLIC
      ${pkgs.rsync}/bin/rsync -avPX --delete -e "/run/current-system/sw/bin/ssh" /mnt/Material#VIDEO 0x0CFF@192.168.31.121:/mnt/Material#VIDEO
    '';
    # 单元配置
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
