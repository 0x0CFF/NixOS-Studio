{ config, pkgs, inputs, ... }:

{
    # 在 /etc/containers 中启用通用容器配置文件
    virtualisation.containers.enable = true;

    virtualisation = {
      docker = {
        enable = true;
        autoPrune.enable = true; # 自动清理无用镜像
      };
    };

    # Docker 相关开发工具
    environment.systemPackages = with pkgs; [
      docker-compose             # [CLI] [GO] Docker 容器编排工具
      lazydocker                 # [TUI] [GO] Docker 可视化管理
    ];

    users.users."0x0CFF" = {
      extraGroups = [
        "docker"
      ];
    };
}
