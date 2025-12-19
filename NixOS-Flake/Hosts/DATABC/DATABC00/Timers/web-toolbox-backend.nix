{ config, pkgs, inputs, ... }:

{
  # 在 timers 服务中启用 systemd 单元
  systemd.timers."web-toolbox-backend" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # 需要运行的单元（脚本或程序）
      Unit = "web-toolbox-backend.service";
      # 系统启动后 1 分钟启动
      OnBootSec = "1min";
      # 如果服务由于意外没有触发，重启时将立即触发该服务
      Persistent = true;
    };
  };

  # 定义 systemd 单元
  systemd.services."web-toolbox-backend" = {
    # 运行脚本
    # 查找程序所在位置 echo $(which ssh)
    script = ''
      set -eu
      cd /home/0x0CFF/Solution/Profiles/Web-Studio/Toolbox-Studio/Backend/
      ${pkgs.uv}/bin/uv run ./main.py
    '';
    # 单元配置
    serviceConfig = {
      Type = "oneshot";
      User = "0x0CFF";
      Persistent = true;
    };
  };
}
