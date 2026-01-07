{ config, pkgs, inputs, ... }:

{
  # 在 timers 服务中启用 systemd 单元
  systemd.timers."web-panel" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # 系统启动 30 秒后启动
      OnBootSec = "30sec";
      # 如果服务在执行时间内由于意外没有触发，则立即补执行
      Persistent = true;
    };
  };

  # 定义 systemd 单元
  systemd.services."web-panel" = {
    # 运行脚本
    # 查找程序所在位置 echo $(which ssh)
    script = ''
      set -eu
      cd /home/0x0CFF/Solution/Blueprints/UV/Web-Studio/Panel-Studio/
      ${pkgs.uv}/bin/uv run ./main.py
    '';
    # 单元配置
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

  # 防火墙端口配置
  networking.firewall = {
      allowedTCPPorts = [
          5000
      ];
      allowedUDPPorts = [
          #
      ];
      allowedUDPPortRanges = [
          #
      ];
  };
}
