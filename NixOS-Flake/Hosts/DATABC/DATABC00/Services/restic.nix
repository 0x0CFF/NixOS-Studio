{ config, pkgs, inputs, ... }:

{
  services = {
    restic.backups = {
      DATABC00 = {
        # 备份路径
        paths = [
          "/mnt/Workspace/协作盘"
          "/mnt/Document/文档盘"
        ];
        # 备份时排除文件/文件夹
        exclude = [
          # "/var/cache"
          # "/home/*/.cache"
          # ".git"
        ];
        # 备份仓库
        repository = "";
        # 如果不存在，则创建该仓库
        initialize = true
        # 仓库密码文件
        passwordFile = "/home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake/Modules/Services/Automation/Restic/Dotfiles/restic-password";
        # 备份定时器
        timerConfig = {
          # 每天 08:00 到 20:00 之间，每 2 个小时运行一次
          OnCalendar = "*-*-* 08..20:00:00/2";
          Persistent = true;
        };
        # 包含访问仓库凭证的文件
        # environmentFile = "/etc/nixos/secrets/restic-environment";
        # 选项列表，格式为 –keep-*，用于 `restic forget –prune` 命令，以自动修剪旧快照
        # 注意： `forget` 命令在 `backup` 命令之后运行，因此构建 –keep-* 选项时请记住这一点
        pruneOpts = [
          "--keep-last 18"
        ];
        # 传递给 restic –option 标志的额外扩展选项
        extraOptions = [
          #
        ];
        # 传递给 restic 备份的额外参数
        extraBackupArgs = [
          "--cleanup-cache"
        ];
        # rclone 配置文件
        rcloneConfigFile = "/home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake/Hosts/DATABC/DATABC00/Services/Dotfiles/rclone.conf";
        # 传递给 rclone 以控制其行为的选项，详细参数查看官方文档： https://rclone.org/docs/#options
        rcloneOptions = {
          bwlimit = "100M:off";           # --bwlimit UP:DOWN 带宽上下行限制，off 表示关闭限制，单位 MiB/s
          cache-chunk-size = "64M";       # --cache-chunk-size 数据块大小
        };
      };
    };
  };
}
