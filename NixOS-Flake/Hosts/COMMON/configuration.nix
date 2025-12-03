{ config, lib, pkgs, ... }:

{
  # 设置时区
  time.timeZone = "Asia/Shanghai";

  # 配置字体
  fonts = {
    fontDir.enable = true;
    # 字体包
    packages = with pkgs; [
      noto-fonts-cjk-sans   # Google CJK 无衬线字体
      noto-fonts-cjk-serif  # Google CJK 衬线字体
      noto-fonts-emoji      # Google Emoji

      # Nerd Fonts
      nerd-fonts.jetbrains-mono     # 编程字体
      nerd-fonts.symbols-only       # 符号字体
      nerd-fonts.dejavu-sans-mono   # 盲文字体
    ];
  };

  # 国际化与输入法
  i18n.defaultLocale = "zh_CN.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # 定义用户，首次构建系统不要忘记使用「passwd」命令设置密码
  users.users."0x0CFF" = {
    isNormalUser = true;
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "wheel"           # 为该用户启用 sudo 权限
      "PUBLIC"
      "ADMINISTRATION"
      "ANIMATION"
      "BOARD"
      "BUSINESS"
      "DESIGN"
      "DEVELOPMENT"
      "EFFECTS"
      "FINANCE"
      "MODELING"
      "OPERATION"
      "PHOTOGRAPHY"
      "VIDEO"
      "R5"
    ];
    # packages = with pkgs; [
    #   tree
    # ];
  };
  # 定义主要用户组（否则工作室对应用户无法创建）
  users.groups.STUDIO = {};
  users.groups.PUBLIC = {};
  users.groups.ADMINISTRATION = {};
  users.groups.ANIMATION = {};
  users.groups.BOARD = {};
  users.groups.BUSINESS = {};
  users.groups.DESIGN = {};
  users.groups.DEVELOPMENT = {};
  users.groups.EFFECTS = {};
  users.groups.FINANCE = {};
  users.groups.MODELING = {};
  users.groups.OPERATION = {};
  users.groups.PHOTOGRAPHY = {};
  users.groups.VIDEO = {};
  users.groups.R0 = {};
  users.groups.R1 = {};
  users.groups.R2 = {};
  users.groups.R3 = {};
  users.groups.R4 = {};
  users.groups.R5 = {};

  nix = {
    # 系统特性
    settings = {
        # 定义 Channels 国内源
        # substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
        # 启用 nix-command、flaskes 特性
        experimental-features = [ "nix-command" "flakes" ];
        # Nix 自动检测 Nix Store 中内容相同的文件，并将它们替换为指向单个副本的硬链接，以节省磁盘空间
        auto-optimise-store = true;
    };
    # 软件频道
    channel = {
      # 删除与 nix-channel 相关的工具和配置，使用 flakes 代替
      enable = false;
    };
    # 启用自动化垃圾回收机制
    gc = {
      automatic = true;                          # 在特定时间自动运行垃圾回收器
      dates = "2weeks";                          # 执行垃圾回收的频率，格式查看：https://www.mankier.com/7/systemd.time
      options = "--delete-older-than 14d";       # 垃圾收集器自动运行时 nix-collect-garbage 的选项
    };
  };

  # 系统程序
  # programs = {
  #   # 一些程序需要 SUID 包装器，可以进一步配置或在用户会话中启动
  #   mtr.enable = true;
  #   gnupg.agent = {
  #     enable = true;
  #     enableSSHSupport = true;
  #   };
  # };

  # 复制 NixOS 配置文件并将其从生成的系统中链接，(/run/current-system/configuration.nix)，这在意外删除 configuration.nix 时很有用
  # system.copySystemConfiguration = true;

  # 这个选项定义了这台设备上安装的第一个 NixOS 版本，用于保持与旧版 NixOS 上创建的应用程序数据（例如数据库）的兼容性
  # 大多数用户在初始安装后，无论出于何种原因都不应该更改这个值，即使已经将系统升级到新的 NixOS 版本
  #
  # 这个值不会影响软件包和操作系统的 Nixpkgs 版本，所以改变它不会升级系统
  # 请参 https://nixos.org/manual/nixos/stable/#sec-upgrading 了解如何实际执行此操作
  #
  # 这个值低于当前的 NixOS 版本并不意味着系统过时、不受支持或容易受到攻击
  # 除非已手动检查它将对配置进行的所有更改，并相应地迁移了数据，否则请勿更改此值
  # 有关详细信息，请参阅 `man configuration.nix` 或 https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "25.05";  # 更改此值前，确定阅读了上面的信息?
}
