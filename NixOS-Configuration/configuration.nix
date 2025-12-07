# 编辑此配置文件以定义应在系统上安装的内容
# 相关帮助请参阅 configuration.nix(5) 手册页、https://search.nixos.org/options 和 NixOS 手册（`nixos-help`）

{ config, lib, pkgs, ... }:

{
  imports =
    [ # 硬件信息
      ./hardware-configuration.nix
    ];

  # 系统引导（根据设备情况选择）
  boot.loader = {
    # 使用 systemd-boot EFI 引导加载程序
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
    # 使用 GRUB 引导加载程序
    # grub.enable = true;
    # grub.device = "nodev";
  };

  # 网络配置
  networking = {
    # 定义主机名
    hostName = "NixOS";
    # 配置网络管理工具，仅选择以下选项之一
    # wireless.enable = true;      # 通过 wpa_supplicant 启用无线支持
    networkmanager.enable = true;  # 易于使用的网络管理工具（大多数发行版默认使用它）
    # 网络代理配置，格式："http://user:password@proxy:port/"
    # proxy = {
    #   default = "http://192.168.31.51:20171/";            # [ 代理服务器 ] V2ray 非分流端口
    #   default = "http://192.168.31.51:20172/";            # [ 代理服务器 ] V2ray 分流端口
    #   noProxy = "127.0.0.1,localhost,internal.domain";    # 代理黑名单
    # };
    # 防火墙端口配置
    firewall = {
      enable = true;                  # 防火墙开关（关闭则完全禁用防火墙）
      allowPing = true;
      allowedTCPPorts = [             # 防火墙 TCP 放行端口
        8384                          # Syncthing
      ];
      # allowedUDPPorts = [ ... ];    # 防火墙 UPD 放行端口
    };
  };

  # 设置时区
  time.timeZone = "Asia/Shanghai";

  # 国际化与输入法
  i18n.defaultLocale = "zh_CN.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # 定义用户，不要忘记使用「passwd」命令设置密码
  users.users."0x0CFF" = {
    isNormalUser = true;
    extraGroups = [
      "wheel"           # 为该用户启用 sudo 权限
    ];
    # packages = with pkgs; [
    #   tree
    # ];
  };

  nix = {
    # 系统特性
    settings = {
        # 定义 Channels 国内源
        # substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
        # 启用 nix-command、flaskes 特性
        experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # 系统服务
  services = {
    # X 图形显示服务器
    # xserver = {
    #   enable = true;
    #   xkb.layout = "us";                       # X11 键盘布局
    #   xkb.options = "eurosign:e,caps:escape";  # X11 键盘映射
    # };
    # 启用 CUPS 以打印文档
    # printing = {
    #   enable = true;
    # };
    # 启用触摸板支持（在大多数桌面管理器中默认启用）
    # libinput = {
    #   enable = true;
    # }
    # 启用声音（pulseaudio 与 pipewire 服务互斥，仅选择以下选项之一）
    # pulseaudio = {
    #   enable = true;
    # }
    # pipewire = {
    #   enable = true;
    #   pulse.enable = true;
    # };
    # OpenSSH 服务
    openssh = {
      enable = true;
    };
    # Syncthing 服务
    syncthing = {
      enable = true;
      user = "0x0CFF";
      dataDir = "/home/0x0CFF";
      guiAddress = "0.0.0.0:8384";
    };
    # Samba 服务
    samba = {
      enable = true;
      openFirewall = true;    # 开放防火墙端口
      settings = {
        # 全局配置
        global = {
          # 设定安全级别，共有 6 种
          # share  : 不需要提供用户名和密码
          # user   : 需要提供用户名和密码，身份验证由 Samba 负责
          # server : 需要提供用户名和密码，可指定其他机器作身份验证
          # domain : 需要提供用户名和密码，指定域服务器作身份验证
          security = "user";
          # 用户登录黑名单
          "invalid users" = [
            "root"
            "0x0CFF"
          ];
        };
      };
    };
    # Web 服务动态发现主机守护程序，使共享对 Windows 10 客户端可见
    # 这使 Samba 主机（如本地 NAS 设备）能够被 Windows 等 Web 服务发现客户端找到
    samba-wsdd = {
      enable = true;                                  # 启用服务
      workgroup = "WORKGROUP";                        # Samba 工作组
    };
  };

  # 系统程序
  programs = {
    # 一些程序需要 SUID 包装器，可以进一步配置或在用户会话中启动
    # mtr.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    # 配置 Bash
    bash = {
      completion.enable = true;    # Tab 补全功能
      # 初始化交互式 Shell 时应运行的额外命令
      # 设置命令别名方便使用
      shellAliases = {
        GIT = "git clone https://github.com/0x0CFF/NixOS-Studio.git ~/Solution/Profiles/NixOS-Studio";
        FLAKE = "sudo sh ~/Solution/Profiles/NixOS-Studio/NixOS-Configuration/nixos-install.sh";
      };
    };
  };

  # 列出系统配置文件中安装包
  # 参阅 https://search.nixos.org/ 来查找更多软件包（和选项）
  # 记得添加编辑器以便编辑 configuration.nix！（默认情况下安装了 Nano 编辑器）
  environment.systemPackages = with pkgs; [
    git            # 版本控制系统
    helix          # 文本编辑器
    yazi           # 文件管理器
    bottom         # 系统任务管理器
    fastfetch      # 系统信息查看工具
  ];

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
