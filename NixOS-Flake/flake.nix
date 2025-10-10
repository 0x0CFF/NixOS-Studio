{
  # 配置文件描述
  description = "NixOS Flakes";

  # 特性
  nixConfig = {
    # 二进制缓存服务器镜像源（覆盖默认 substituters）
    # extra-substituters = [
    #   "https://cache.nixos.org"                                     # 官方二进制缓存服务器
    #   "https://mirrors.ustc.edu.cn/nix-channels/store"              # 中国科学技术大学
    #   "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"     # 清华大学
    #   "https://mirrors.nju.edu.cn/nix-channels/store"               # 南京大学
    #   "https://mirror.sjtu.edu.cn/nix-channels/store"               # 上海交通大学
    #   "https://mirrors.cqupt.edu.cn/nix-channels/store"             # 重庆邮电大学
    #   "https://mirror.nyist.edu.cn/nix-channels/store"              # 南阳理工大学
    #   "https://mirror.iscas.ac.cn/nix-channels/store"               # ISCAS
    # ];
  };

  # 输入
  # flake inputs 有很多种引用方式，应用最广泛的格式是: github:owner/name/<reference>
  # reference 类型：branch、commit hash、tag，即：
  # github:owner/name/<branch>
  # github:owner/name/<commit hash>（最彻底的锁定方式）
  # github:owner/name/<tag>
  inputs = {
    # NixOS 官方硬件信息
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # NixOS 官方软件源，nixos-25.05 分支
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # NixOS 官方软件源，非稳定版本
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # home-manager，用于管理用户配置
    home-manager = {
      # home-manager 官方源，home-manager-25.05 分支
      url = "github:nix-community/home-manager/release-25.05";
      # 强制 home-manager 和该 flake 使用相同版本的 nixpkgs，避免依赖的 nixpkgs 版本不一致导致问题
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 软件源
    helix.url = "github:helix-editor/helix/master";
  };

  # 输出
  # self 参数指向 outputs 自身（自引用），以及 flake 根目录
  # nixpkgs, nixpkgs-unstable, home-manager 为 inputs 输出函数所定义
  # @ 语法将函数的参数 attribute set （属性集）取了个别名，方便在函数内部使用
  outputs = inputs@{ self, nixpkgs, unstable, home-manager, ... }:{
    # 可以在 outputs 函数中使用 nixosConfigurations.<Hostname> 定义多个系统配置
    # NixOS 构建系统时会根据主机名 Hostname 决定使用哪个配置
    # nixpkgs.lib.nixosSystem 函数用于构建配置

    # NODENS 系列 （Node Network Server，节点网络服务器）#########################################################

    # 定义 NODENS00 系统配置
    nixosConfigurations."NODENS00" = nixpkgs.lib.nixosSystem {
      # 系统架构类型
      system = "x86_64-linux";
      # 传递非默认参数到子模块系统
      specialArgs = { inherit inputs; };
      # 引用子模块
      modules = [
        # 设备底层
        ./Hosts/COMMON/configuration.nix                               # 基础配置 [ 通用 ]
        ./Hosts/COMMON/environment.nix                                 # 环境变量 [ 通用 ]
        ./Hosts/NODENS/NODENS00/Device/configuration.nix               # 基础配置
        ./Hosts/NODENS/NODENS00/Device/environment.nix                 # 环境变量
        ./Hosts/NODENS/NODENS00/Device/hardware-configuration.nix      # 硬件信息
        # 服务专项配置
        # ./Hosts/NODENS/NODENS00/Services/samba.nix                     # Samba 专项配置
        # 定时服务
        ./Hosts/NODENS/NODENS00/Timers/samba-gc.nix                    # Samba 垃圾回收
        ./Hosts/NODENS/NODENS00/Timers/web-panel.nix                   # 导航面板
        ./Hosts/NODENS/NODENS00/Timers/web-toolbox-backend.nix         # 工具箱面板-后端
        ./Hosts/NODENS/NODENS00/Timers/web-toolbox-frontend.nix        # 工具箱面板-前端

        # 程序集合
        # ./Modules/Crates/Desktop/Browser/default.nix                   # 文件类型浏览器集合
        # ./Modules/Crates/Desktop/DE/default.nix                        # 桌面环境集合
        # ./Modules/Crates/Desktop/Editor/default.nix                    # 文件类型编辑器集合
        ./Modules/Crates/Development/Python/default.nix                # Python 开发工具集合
        ./Modules/Crates/Operations/Explorer/default.nix               # 终端文件管理器程序集合
        ./Modules/Crates/Operations/Git/default.nix                    # Git 程序集合
        ./Modules/Crates/Operations/Hardware/default.nix               # 硬件管理程序集合
        ./Modules/Crates/Operations/Multimedia/default.nix             # 多媒体处理程序集合
        ./Modules/Crates/Operations/Terminal/default.nix               # 终端环境程序集合
        
        # 硬件驱动
        ./Modules/Driver/Audio/default.nix                             # 声音驱动
        # ./Modules/Driver/Bluetooth/default.nix                         # 蓝牙驱动
        # ./Modules/Driver/Printer/default.nix                           # 打印机驱动
        # ./Modules/Driver/Touchpad/default.nix                          # 触控板驱动
        # ./Modules/Driver/USB/default.nix                               # USB 驱动
        # ./Modules/Driver/Xserver/default.nix                           # Xserver 驱动

        # ./Modules/Services/Automation/HomeAssistant/default.nix        # 智能家居平台
        # ./Modules/Services/Automation/N8N/default.nix                  # 工作流自动化平台
        ./Modules/Services/Network/AdguardHome/default.nix             # 网络拦截平台
        ./Modules/Services/Network/OpenSSH/default.nix                 # 远程控制服务
        ./Modules/Services/Network/Samba/default.nix                   # 文件共享服务
        ./Modules/Services/Network/Syncthing/default.nix               # 文件同步服务
        ./Modules/Services/Network/V2raya/default.nix                  # 网络代理服务
        # ./Modules/Services/Produce/Ollama/default.nix                  # 本地 LLM 运行框架
        # ./Modules/Services/Produce/OpenWebUI/default.nix               # AI 应用平台
        # ./Modules/Services/Security/Duplicati/default.nix              # 云盘备份服务
        # ./Modules/Services/Security/Frigate/default.nix                # 网络录像服务
        # ./Modules/Services/Security/VaultWarden/default.nix            # 密码管理服务

        # 容器引擎
        ./Modules/Virtualisation/Docker/default.nix                    # Docker 引擎

        # 用户成员
        ./Users/ADMINISTRATION/default.nix                             # 行政部门
        ./Users/ANIMATION/default.nix                                  # 动画部门
        ./Users/BOARD/default.nix                                      # 董事会
        ./Users/BUSINESS/default.nix                                   # 商务部门
        ./Users/DESIGN/default.nix                                     # 设计部门
        ./Users/DEVELOPMENT/default.nix                                # 开发部门
        ./Users/FINANCE/default.nix                                    # 财务部门
        ./Users/VIDEO/default.nix                                      # 视频部门

        # 将所有 inputs 输入函数中所有的变量设为 home-manager 模块的特殊参数，这样 home-manager 子模块中可进行调用
        home-manager.extraSpecialArgs = { inherit inputs; };
        # 用户 home-manager（执行 nixos-rebuild switch 时，home-manager 配置会被自动部署）
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."0x0CFF" = {
            # ./Modules/Crates/Desktop/DE/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Explorer/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Terminal/Dotfiles/dotfiles.nix
          };
        };
      ]
    };

    # 定义 NODENS01 系统配置
    nixosConfigurations."NODENS01" = nixpkgs.lib.nixosSystem {
      # 系统架构类型
      system = "x86_64-linux";
      # 传递非默认参数到子模块系统
      specialArgs = { inherit inputs; };
      # 引用子模块
      modules = [
        # 设备底层
        ./Hosts/COMMON/configuration.nix                               # 基础配置 [ 通用 ]
        ./Hosts/COMMON/environment.nix                                 # 环境变量 [ 通用 ]
        ./Hosts/NODENS/NODENS01/Device/configuration.nix               # 基础配置
        ./Hosts/NODENS/NODENS01/Device/environment.nix                 # 环境变量
        ./Hosts/NODENS/NODENS01/Device/hardware-configuration.nix      # 硬件信息
        # 服务专项配置
        # ./Hosts/NODENS/NODENS01/Services/samba.nix                     # Samba 专项配置
        # 定时服务
        ./Hosts/NODENS/NODENS01/Timers/data-backup.nix                 # 数据备份
        ./Hosts/NODENS/NODENS01/Timers/mnt-backup.nix                  # 数据备份
        ./Hosts/NODENS/NODENS01/Timers/samba-gc.nix                    # Samba 垃圾回收

        # 程序集合
        # ./Modules/Crates/Desktop/Browser/default.nix                   # 文件类型浏览器集合
        # ./Modules/Crates/Desktop/DE/default.nix                        # 桌面环境集合
        # ./Modules/Crates/Desktop/Editor/default.nix                    # 文件类型编辑器集合
        ./Modules/Crates/Development/Python/default.nix                # Python 开发工具集合
        ./Modules/Crates/Operations/Explorer/default.nix               # 终端文件管理器程序集合
        ./Modules/Crates/Operations/Git/default.nix                    # Git 程序集合
        ./Modules/Crates/Operations/Hardware/default.nix               # 硬件管理程序集合
        ./Modules/Crates/Operations/Multimedia/default.nix             # 多媒体处理程序集合
        ./Modules/Crates/Operations/Terminal/default.nix               # 终端环境程序集合
        
        # 硬件驱动
        ./Modules/Driver/Audio/default.nix                             # 声音驱动
        # ./Modules/Driver/Bluetooth/default.nix                         # 蓝牙驱动
        # ./Modules/Driver/Printer/default.nix                           # 打印机驱动
        # ./Modules/Driver/Touchpad/default.nix                          # 触控板驱动
        # ./Modules/Driver/USB/default.nix                               # USB 驱动
        # ./Modules/Driver/Xserver/default.nix                           # Xserver 驱动

        # ./Modules/Services/Automation/HomeAssistant/default.nix        # 智能家居平台
        # ./Modules/Services/Automation/N8N/default.nix                  # 工作流自动化平台
        # ./Modules/Services/Network/AdguardHome/default.nix             # 网络拦截平台
        ./Modules/Services/Network/OpenSSH/default.nix                 # 远程控制服务
        ./Modules/Services/Network/Samba/default.nix                   # 文件共享服务
        ./Modules/Services/Network/Syncthing/default.nix               # 文件同步服务
        # ./Modules/Services/Network/V2raya/default.nix                  # 网络代理服务
        # ./Modules/Services/Produce/Ollama/default.nix                  # 本地 LLM 运行框架
        # ./Modules/Services/Produce/OpenWebUI/default.nix               # AI 应用平台
        # ./Modules/Services/Security/Duplicati/default.nix              # 云盘备份服务
        # ./Modules/Services/Security/Frigate/default.nix                # 网络录像服务
        # ./Modules/Services/Security/VaultWarden/default.nix            # 密码管理服务

        # 容器引擎
        ./Modules/Virtualisation/Docker/default.nix                    # Docker 引擎

        # 用户成员
        ./Users/ADMINISTRATION/default.nix                             # 行政部门
        ./Users/ANIMATION/default.nix                                  # 动画部门
        ./Users/BOARD/default.nix                                      # 董事会
        ./Users/BUSINESS/default.nix                                   # 商务部门
        ./Users/DESIGN/default.nix                                     # 设计部门
        ./Users/DEVELOPMENT/default.nix                                # 开发部门
        ./Users/FINANCE/default.nix                                    # 财务部门
        ./Users/VIDEO/default.nix                                      # 视频部门

        # 将所有 inputs 输入函数中所有的变量设为 home-manager 模块的特殊参数，这样 home-manager 子模块中可进行调用
        home-manager.extraSpecialArgs = { inherit inputs; };
        # 用户 home-manager（执行 nixos-rebuild switch 时，home-manager 配置会被自动部署）
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."0x0CFF" = {
            # ./Modules/Crates/Desktop/DE/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Explorer/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Terminal/Dotfiles/dotfiles.nix
          };
        };
      ]
    };

    # DATASC 系列（Data Storage Center，数据存储中心） ###########################################################

    # 定义 DATASC00 系统配置
    nixosConfigurations."DATASC00" = nixpkgs.lib.nixosSystem {
      # 系统架构类型
      system = "x86_64-linux";
      # 传递非默认参数到子模块系统
      specialArgs = { inherit inputs; };
      # 引用子模块
      modules = [
        # 设备底层
        ./Hosts/COMMON/configuration.nix                               # 基础配置 [ 通用 ]
        ./Hosts/COMMON/environment.nix                                 # 环境变量 [ 通用 ]
        ./Hosts/DATASC/DATASC00/Device/configuration.nix               # 基础配置
        ./Hosts/DATASC/DATASC00/Device/environment.nix                 # 环境变量
        ./Hosts/DATASC/DATASC00/Device/hardware-configuration.nix      # 硬件信息
        # 服务专项配置
        # ./Hosts/DATASC/DATASC00/Services/samba.nix                     # Samba 专项配置
        # 定时服务
        ./Hosts/DATASC/DATASC00/Timers/mnt-backup.nix                  # 数据备份

        # 程序集合
        # ./Modules/Crates/Desktop/Browser/default.nix                   # 文件类型浏览器集合
        # ./Modules/Crates/Desktop/DE/default.nix                        # 桌面环境集合
        # ./Modules/Crates/Desktop/Editor/default.nix                    # 文件类型编辑器集合
        ./Modules/Crates/Development/Python/default.nix                # Python 开发工具集合
        ./Modules/Crates/Operations/Explorer/default.nix               # 终端文件管理器程序集合
        ./Modules/Crates/Operations/Git/default.nix                    # Git 程序集合
        ./Modules/Crates/Operations/Hardware/default.nix               # 硬件管理程序集合
        ./Modules/Crates/Operations/Multimedia/default.nix             # 多媒体处理程序集合
        ./Modules/Crates/Operations/Terminal/default.nix               # 终端环境程序集合
        
        # 硬件驱动
        ./Modules/Driver/Audio/default.nix                             # 声音驱动
        # ./Modules/Driver/Bluetooth/default.nix                         # 蓝牙驱动
        # ./Modules/Driver/Printer/default.nix                           # 打印机驱动
        # ./Modules/Driver/Touchpad/default.nix                          # 触控板驱动
        # ./Modules/Driver/USB/default.nix                               # USB 驱动
        # ./Modules/Driver/Xserver/default.nix                           # Xserver 驱动

        # ./Modules/Services/Automation/HomeAssistant/default.nix        # 智能家居平台
        # ./Modules/Services/Automation/N8N/default.nix                  # 工作流自动化平台
        # ./Modules/Services/Network/AdguardHome/default.nix             # 网络拦截平台
        ./Modules/Services/Network/OpenSSH/default.nix                 # 远程控制服务
        ./Modules/Services/Network/Samba/default.nix                   # 文件共享服务
        ./Modules/Services/Network/Syncthing/default.nix               # 文件同步服务
        # ./Modules/Services/Network/V2raya/default.nix                  # 网络代理服务
        # ./Modules/Services/Produce/Ollama/default.nix                  # 本地 LLM 运行框架
        # ./Modules/Services/Produce/OpenWebUI/default.nix               # AI 应用平台
        # ./Modules/Services/Security/Duplicati/default.nix              # 云盘备份服务
        # ./Modules/Services/Security/Frigate/default.nix                # 网络录像服务
        # ./Modules/Services/Security/VaultWarden/default.nix            # 密码管理服务

        # 容器引擎
        ./Modules/Virtualisation/Docker/default.nix                    # Docker 引擎

        # 用户成员
        ./Users/ADMINISTRATION/default.nix                             # 行政部门
        ./Users/ANIMATION/default.nix                                  # 动画部门
        ./Users/BOARD/default.nix                                      # 董事会
        ./Users/BUSINESS/default.nix                                   # 商务部门
        ./Users/DESIGN/default.nix                                     # 设计部门
        ./Users/DEVELOPMENT/default.nix                                # 开发部门
        ./Users/FINANCE/default.nix                                    # 财务部门
        ./Users/VIDEO/default.nix                                      # 视频部门

        # 将所有 inputs 输入函数中所有的变量设为 home-manager 模块的特殊参数，这样 home-manager 子模块中可进行调用
        home-manager.extraSpecialArgs = { inherit inputs; };
        # 用户 home-manager（执行 nixos-rebuild switch 时，home-manager 配置会被自动部署）
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."0x0CFF" = {
            # ./Modules/Crates/Desktop/DE/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Explorer/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Terminal/Dotfiles/dotfiles.nix
          };
        };
      ]
    };

    # 定义 DATASC01 系统配置
    nixosConfigurations."DATASC01" = nixpkgs.lib.nixosSystem {
      # 系统架构类型
      system = "x86_64-linux";
      # 传递非默认参数到子模块系统
      specialArgs = { inherit inputs; };
      # 引用子模块
      modules = [
        # 设备底层
        ./Hosts/COMMON/configuration.nix                               # 基础配置 [ 通用 ]
        ./Hosts/COMMON/environment.nix                                 # 环境变量 [ 通用 ]
        ./Hosts/DATASC/DATASC01/Device/configuration.nix               # 基础配置
        ./Hosts/DATASC/DATASC01/Device/environment.nix                 # 环境变量
        ./Hosts/DATASC/DATASC01/Device/hardware-configuration.nix      # 硬件信息
        # 服务专项配置
        # ./Hosts/DATASC/DATASC01/Services/samba.nix                     # Samba 专项配置
        # 定时服务
        ./Hosts/DATASC/DATASC01/Timers/mnt-backup.nix                  # 数据备份
        ./Hosts/DATASC/DATASC01/Timers/samba-gc.nix                    # Samba 垃圾回收

        # 程序集合
        # ./Modules/Crates/Desktop/Browser/default.nix                   # 文件类型浏览器集合
        # ./Modules/Crates/Desktop/DE/default.nix                        # 桌面环境集合
        # ./Modules/Crates/Desktop/Editor/default.nix                    # 文件类型编辑器集合
        ./Modules/Crates/Development/Python/default.nix                # Python 开发工具集合
        ./Modules/Crates/Operations/Explorer/default.nix               # 终端文件管理器程序集合
        ./Modules/Crates/Operations/Git/default.nix                    # Git 程序集合
        ./Modules/Crates/Operations/Hardware/default.nix               # 硬件管理程序集合
        ./Modules/Crates/Operations/Multimedia/default.nix             # 多媒体处理程序集合
        ./Modules/Crates/Operations/Terminal/default.nix               # 终端环境程序集合
        
        # 硬件驱动
        ./Modules/Driver/Audio/default.nix                             # 声音驱动
        # ./Modules/Driver/Bluetooth/default.nix                         # 蓝牙驱动
        # ./Modules/Driver/Printer/default.nix                           # 打印机驱动
        # ./Modules/Driver/Touchpad/default.nix                          # 触控板驱动
        # ./Modules/Driver/USB/default.nix                               # USB 驱动
        # ./Modules/Driver/Xserver/default.nix                           # Xserver 驱动

        # ./Modules/Services/Automation/HomeAssistant/default.nix        # 智能家居平台
        # ./Modules/Services/Automation/N8N/default.nix                  # 工作流自动化平台
        # ./Modules/Services/Network/AdguardHome/default.nix             # 网络拦截平台
        ./Modules/Services/Network/OpenSSH/default.nix                 # 远程控制服务
        ./Modules/Services/Network/Samba/default.nix                   # 文件共享服务
        ./Modules/Services/Network/Syncthing/default.nix               # 文件同步服务
        # ./Modules/Services/Network/V2raya/default.nix                  # 网络代理服务
        # ./Modules/Services/Produce/Ollama/default.nix                  # 本地 LLM 运行框架
        # ./Modules/Services/Produce/OpenWebUI/default.nix               # AI 应用平台
        # ./Modules/Services/Security/Duplicati/default.nix              # 云盘备份服务
        # ./Modules/Services/Security/Frigate/default.nix                # 网络录像服务
        # ./Modules/Services/Security/VaultWarden/default.nix            # 密码管理服务

        # 容器引擎
        ./Modules/Virtualisation/Docker/default.nix                    # Docker 引擎

        # 用户成员
        ./Users/ADMINISTRATION/default.nix                             # 行政部门
        ./Users/ANIMATION/default.nix                                  # 动画部门
        ./Users/BOARD/default.nix                                      # 董事会
        ./Users/BUSINESS/default.nix                                   # 商务部门
        ./Users/DESIGN/default.nix                                     # 设计部门
        ./Users/DEVELOPMENT/default.nix                                # 开发部门
        ./Users/FINANCE/default.nix                                    # 财务部门
        ./Users/VIDEO/default.nix                                      # 视频部门

        # 将所有 inputs 输入函数中所有的变量设为 home-manager 模块的特殊参数，这样 home-manager 子模块中可进行调用
        home-manager.extraSpecialArgs = { inherit inputs; };
        # 用户 home-manager（执行 nixos-rebuild switch 时，home-manager 配置会被自动部署）
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."0x0CFF" = {
            # ./Modules/Crates/Desktop/DE/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Explorer/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Terminal/Dotfiles/dotfiles.nix
          };
        };
      ]
    };

    # DATABC 系列（Data Backup Center，数据备份中心） ############################################################

    # 定义 DATABC00 系统配置
    nixosConfigurations."DATABC00" = nixpkgs.lib.nixosSystem {
      # 系统架构类型
      system = "x86_64-linux";
      # 传递非默认参数到子模块系统
      specialArgs = { inherit inputs; };
      # 引用子模块
      modules = [
        # 设备底层
        ./Hosts/COMMON/configuration.nix                               # 基础配置 [ 通用 ]
        ./Hosts/COMMON/environment.nix                                 # 环境变量 [ 通用 ]
        ./Hosts/DATABC/DATABC00/Device/configuration.nix               # 基础配置
        ./Hosts/DATABC/DATABC00/Device/environment.nix                 # 环境变量
        ./Hosts/DATABC/DATABC00/Device/hardware-configuration.nix      # 硬件信息
        # 服务专项配置
        # ./Hosts/DATABC/DATABC00/Services/samba.nix                     # Samba 专项配置
        # 定时服务

        # 程序集合
        # ./Modules/Crates/Desktop/Browser/default.nix                   # 文件类型浏览器集合
        # ./Modules/Crates/Desktop/DE/default.nix                        # 桌面环境集合
        # ./Modules/Crates/Desktop/Editor/default.nix                    # 文件类型编辑器集合
        ./Modules/Crates/Development/Python/default.nix                # Python 开发工具集合
        ./Modules/Crates/Operations/Explorer/default.nix               # 终端文件管理器程序集合
        ./Modules/Crates/Operations/Git/default.nix                    # Git 程序集合
        ./Modules/Crates/Operations/Hardware/default.nix               # 硬件管理程序集合
        ./Modules/Crates/Operations/Multimedia/default.nix             # 多媒体处理程序集合
        ./Modules/Crates/Operations/Terminal/default.nix               # 终端环境程序集合
        
        # 硬件驱动
        ./Modules/Driver/Audio/default.nix                             # 声音驱动
        # ./Modules/Driver/Bluetooth/default.nix                         # 蓝牙驱动
        # ./Modules/Driver/Printer/default.nix                           # 打印机驱动
        # ./Modules/Driver/Touchpad/default.nix                          # 触控板驱动
        # ./Modules/Driver/USB/default.nix                               # USB 驱动
        # ./Modules/Driver/Xserver/default.nix                           # Xserver 驱动

        # ./Modules/Services/Automation/HomeAssistant/default.nix        # 智能家居平台
        # ./Modules/Services/Automation/N8N/default.nix                  # 工作流自动化平台
        # ./Modules/Services/Network/AdguardHome/default.nix             # 网络拦截平台
        ./Modules/Services/Network/OpenSSH/default.nix                 # 远程控制服务
        ./Modules/Services/Network/Samba/default.nix                   # 文件共享服务
        ./Modules/Services/Network/Syncthing/default.nix               # 文件同步服务
        # ./Modules/Services/Network/V2raya/default.nix                  # 网络代理服务
        # ./Modules/Services/Produce/Ollama/default.nix                  # 本地 LLM 运行框架
        # ./Modules/Services/Produce/OpenWebUI/default.nix               # AI 应用平台
        # ./Modules/Services/Security/Duplicati/default.nix              # 云盘备份服务
        # ./Modules/Services/Security/Frigate/default.nix                # 网络录像服务
        # ./Modules/Services/Security/VaultWarden/default.nix            # 密码管理服务

        # 容器引擎
        ./Modules/Virtualisation/Docker/default.nix                    # Docker 引擎

        # 用户成员
        ./Users/ADMINISTRATION/default.nix                             # 行政部门
        ./Users/ANIMATION/default.nix                                  # 动画部门
        ./Users/BOARD/default.nix                                      # 董事会
        ./Users/BUSINESS/default.nix                                   # 商务部门
        ./Users/DESIGN/default.nix                                     # 设计部门
        ./Users/DEVELOPMENT/default.nix                                # 开发部门
        ./Users/FINANCE/default.nix                                    # 财务部门
        ./Users/VIDEO/default.nix                                      # 视频部门

        # 将所有 inputs 输入函数中所有的变量设为 home-manager 模块的特殊参数，这样 home-manager 子模块中可进行调用
        home-manager.extraSpecialArgs = { inherit inputs; };
        # 用户 home-manager（执行 nixos-rebuild switch 时，home-manager 配置会被自动部署）
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."0x0CFF" = {
            # ./Modules/Crates/Desktop/DE/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Explorer/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Terminal/Dotfiles/dotfiles.nix
          };
        };
      ]
    };

    # 定义 DATABC01 系统配置
    nixosConfigurations."DATABC01" = nixpkgs.lib.nixosSystem {
      # 系统架构类型
      system = "x86_64-linux";
      # 传递非默认参数到子模块系统
      specialArgs = { inherit inputs; };
      # 引用子模块
      modules = [
        # 设备底层
        ./Hosts/COMMON/configuration.nix                               # 基础配置 [ 通用 ]
        ./Hosts/COMMON/environment.nix                                 # 环境变量 [ 通用 ]
        ./Hosts/DATABC/DATABC01/Device/configuration.nix               # 基础配置
        ./Hosts/DATABC/DATABC01/Device/environment.nix                 # 环境变量
        ./Hosts/DATABC/DATABC01/Device/hardware-configuration.nix      # 硬件信息
        # 服务专项配置
        # ./Hosts/DATABC/DATABC01/Services/samba.nix                     # Samba 专项配置
        # 定时服务
        ./Hosts/DATABC/DATABC01/Timers/samba-gc.nix                    # Samba 垃圾回收

        # 程序集合
        # ./Modules/Crates/Desktop/Browser/default.nix                   # 文件类型浏览器集合
        # ./Modules/Crates/Desktop/DE/default.nix                        # 桌面环境集合
        # ./Modules/Crates/Desktop/Editor/default.nix                    # 文件类型编辑器集合
        ./Modules/Crates/Development/Python/default.nix                # Python 开发工具集合
        ./Modules/Crates/Operations/Explorer/default.nix               # 终端文件管理器程序集合
        ./Modules/Crates/Operations/Git/default.nix                    # Git 程序集合
        ./Modules/Crates/Operations/Hardware/default.nix               # 硬件管理程序集合
        ./Modules/Crates/Operations/Multimedia/default.nix             # 多媒体处理程序集合
        ./Modules/Crates/Operations/Terminal/default.nix               # 终端环境程序集合
        
        # 硬件驱动
        ./Modules/Driver/Audio/default.nix                             # 声音驱动
        # ./Modules/Driver/Bluetooth/default.nix                         # 蓝牙驱动
        # ./Modules/Driver/Printer/default.nix                           # 打印机驱动
        # ./Modules/Driver/Touchpad/default.nix                          # 触控板驱动
        # ./Modules/Driver/USB/default.nix                               # USB 驱动
        # ./Modules/Driver/Xserver/default.nix                           # Xserver 驱动

        # ./Modules/Services/Automation/HomeAssistant/default.nix        # 智能家居平台
        # ./Modules/Services/Automation/N8N/default.nix                  # 工作流自动化平台
        # ./Modules/Services/Network/AdguardHome/default.nix             # 网络拦截平台
        ./Modules/Services/Network/OpenSSH/default.nix                 # 远程控制服务
        ./Modules/Services/Network/Samba/default.nix                   # 文件共享服务
        ./Modules/Services/Network/Syncthing/default.nix               # 文件同步服务
        # ./Modules/Services/Network/V2raya/default.nix                  # 网络代理服务
        # ./Modules/Services/Produce/Ollama/default.nix                  # 本地 LLM 运行框架
        # ./Modules/Services/Produce/OpenWebUI/default.nix               # AI 应用平台
        # ./Modules/Services/Security/Duplicati/default.nix              # 云盘备份服务
        # ./Modules/Services/Security/Frigate/default.nix                # 网络录像服务
        # ./Modules/Services/Security/VaultWarden/default.nix            # 密码管理服务

        # 容器引擎
        ./Modules/Virtualisation/Docker/default.nix                    # Docker 引擎

        # 用户成员
        ./Users/ADMINISTRATION/default.nix                             # 行政部门
        ./Users/ANIMATION/default.nix                                  # 动画部门
        ./Users/BOARD/default.nix                                      # 董事会
        ./Users/BUSINESS/default.nix                                   # 商务部门
        ./Users/DESIGN/default.nix                                     # 设计部门
        ./Users/DEVELOPMENT/default.nix                                # 开发部门
        ./Users/FINANCE/default.nix                                    # 财务部门
        ./Users/VIDEO/default.nix                                      # 视频部门

        # 将所有 inputs 输入函数中所有的变量设为 home-manager 模块的特殊参数，这样 home-manager 子模块中可进行调用
        home-manager.extraSpecialArgs = { inherit inputs; };
        # 用户 home-manager（执行 nixos-rebuild switch 时，home-manager 配置会被自动部署）
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."0x0CFF" = {
            # ./Modules/Crates/Desktop/DE/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Explorer/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Terminal/Dotfiles/dotfiles.nix
          };
        };
      ]
    };

    # DATAHC 系列（Data Handling Center，数据处理中心） ##########################################################

    # 定义 DATAHC00 系统配置
    nixosConfigurations."DATAHC00" = nixpkgs.lib.nixosSystem {
      # 系统架构类型
      system = "x86_64-linux";
      # 传递非默认参数到子模块系统
      specialArgs = { inherit inputs; };
      # 引用子模块
      modules = [
        # 设备底层
        ./Hosts/COMMON/configuration.nix                               # 基础配置 [ 通用 ]
        ./Hosts/COMMON/environment.nix                                 # 环境变量 [ 通用 ]
        ./Hosts/DATAHC/DATAHC00/Device/configuration.nix               # 基础配置
        ./Hosts/DATAHC/DATAHC00/Device/environment.nix                 # 环境变量
        ./Hosts/DATAHC/DATAHC00/Device/hardware-configuration.nix      # 硬件信息
        # 服务专项配置
        
        # 定时服务

        # 程序集合
        # ./Modules/Crates/Desktop/Browser/default.nix                   # 文件类型浏览器集合
        # ./Modules/Crates/Desktop/DE/default.nix                        # 桌面环境集合
        # ./Modules/Crates/Desktop/Editor/default.nix                    # 文件类型编辑器集合
        ./Modules/Crates/Development/Python/default.nix                # Python 开发工具集合
        ./Modules/Crates/Operations/Explorer/default.nix               # 终端文件管理器程序集合
        ./Modules/Crates/Operations/Git/default.nix                    # Git 程序集合
        ./Modules/Crates/Operations/Hardware/default.nix               # 硬件管理程序集合
        ./Modules/Crates/Operations/Multimedia/default.nix             # 多媒体处理程序集合
        ./Modules/Crates/Operations/Terminal/default.nix               # 终端环境程序集合
        
        # 硬件驱动
        ./Modules/Driver/Audio/default.nix                             # 声音驱动
        # ./Modules/Driver/Bluetooth/default.nix                         # 蓝牙驱动
        # ./Modules/Driver/Printer/default.nix                           # 打印机驱动
        # ./Modules/Driver/Touchpad/default.nix                          # 触控板驱动
        # ./Modules/Driver/USB/default.nix                               # USB 驱动
        # ./Modules/Driver/Xserver/default.nix                           # Xserver 驱动

        # ./Modules/Services/Automation/HomeAssistant/default.nix        # 智能家居平台
        # ./Modules/Services/Automation/N8N/default.nix                  # 工作流自动化平台
        # ./Modules/Services/Network/AdguardHome/default.nix             # 网络拦截平台
        ./Modules/Services/Network/OpenSSH/default.nix                 # 远程控制服务
        # ./Modules/Services/Network/Samba/default.nix                   # 文件共享服务
        ./Modules/Services/Network/Syncthing/default.nix               # 文件同步服务
        # ./Modules/Services/Network/V2raya/default.nix                  # 网络代理服务
        ./Modules/Services/Produce/Ollama/default.nix                  # 本地 LLM 运行框架
        ./Modules/Services/Produce/OpenWebUI/default.nix               # AI 应用平台
        # ./Modules/Services/Security/Duplicati/default.nix                # 云盘备份服务
        ./Modules/Services/Security/Frigate/default.nix                # 网络录像服务
        # ./Modules/Services/Security/VaultWarden/default.nix            # 密码管理服务

        # 容器引擎
        ./Modules/Virtualisation/Docker/default.nix                    # Docker 引擎

        # 用户成员
        ./Users/ADMINISTRATION/default.nix                             # 行政部门
        ./Users/ANIMATION/default.nix                                  # 动画部门
        ./Users/BOARD/default.nix                                      # 董事会
        ./Users/BUSINESS/default.nix                                   # 商务部门
        ./Users/DESIGN/default.nix                                     # 设计部门
        ./Users/DEVELOPMENT/default.nix                                # 开发部门
        ./Users/FINANCE/default.nix                                    # 财务部门
        ./Users/VIDEO/default.nix                                      # 视频部门

        # 将所有 inputs 输入函数中所有的变量设为 home-manager 模块的特殊参数，这样 home-manager 子模块中可进行调用
        home-manager.extraSpecialArgs = { inherit inputs; };
        # 用户 home-manager（执行 nixos-rebuild switch 时，home-manager 配置会被自动部署）
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."0x0CFF" = {
            # ./Modules/Crates/Desktop/DE/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Explorer/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Terminal/Dotfiles/dotfiles.nix
          };
        };
      ]
    };

    # 定义 DATAHC01 系统配置
    nixosConfigurations."DATAHC01" = nixpkgs.lib.nixosSystem {
      # 系统架构类型
      system = "x86_64-linux";
      # 传递非默认参数到子模块系统
      specialArgs = { inherit inputs; };
      # 引用子模块
      modules = [
        # 设备底层
        ./Hosts/COMMON/configuration.nix                               # 基础配置 [ 通用 ]
        ./Hosts/COMMON/environment.nix                                 # 环境变量 [ 通用 ]
        ./Hosts/DATAHC/DATAHC01/Device/configuration.nix               # 基础配置
        ./Hosts/DATAHC/DATAHC01/Device/environment.nix                 # 环境变量
        ./Hosts/DATAHC/DATAHC01/Device/hardware-configuration.nix      # 硬件信息
        # 服务专项配置
        
        # 定时服务

        # 程序集合
        # ./Modules/Crates/Desktop/Browser/default.nix                   # 文件类型浏览器集合
        # ./Modules/Crates/Desktop/DE/default.nix                        # 桌面环境集合
        # ./Modules/Crates/Desktop/Editor/default.nix                    # 文件类型编辑器集合
        ./Modules/Crates/Development/Python/default.nix                # Python 开发工具集合
        ./Modules/Crates/Operations/Explorer/default.nix               # 终端文件管理器程序集合
        ./Modules/Crates/Operations/Git/default.nix                    # Git 程序集合
        ./Modules/Crates/Operations/Hardware/default.nix               # 硬件管理程序集合
        ./Modules/Crates/Operations/Multimedia/default.nix             # 多媒体处理程序集合
        ./Modules/Crates/Operations/Terminal/default.nix               # 终端环境程序集合
        
        # 硬件驱动
        ./Modules/Driver/Audio/default.nix                             # 声音驱动
        # ./Modules/Driver/Bluetooth/default.nix                         # 蓝牙驱动
        # ./Modules/Driver/Printer/default.nix                           # 打印机驱动
        # ./Modules/Driver/Touchpad/default.nix                          # 触控板驱动
        # ./Modules/Driver/USB/default.nix                               # USB 驱动
        # ./Modules/Driver/Xserver/default.nix                           # Xserver 驱动

        # ./Modules/Services/Automation/HomeAssistant/default.nix        # 智能家居平台
        # ./Modules/Services/Automation/N8N/default.nix                  # 工作流自动化平台
        # ./Modules/Services/Network/AdguardHome/default.nix             # 网络拦截平台
        ./Modules/Services/Network/OpenSSH/default.nix                 # 远程控制服务
        # ./Modules/Services/Network/Samba/default.nix                   # 文件共享服务
        ./Modules/Services/Network/Syncthing/default.nix               # 文件同步服务
        # ./Modules/Services/Network/V2raya/default.nix                  # 网络代理服务
        # ./Modules/Services/Produce/Ollama/default.nix                  # 本地 LLM 运行框架
        # ./Modules/Services/Produce/OpenWebUI/default.nix               # AI 应用平台
        # ./Modules/Services/Security/Duplicati/default.nix              # 云盘备份服务
        # ./Modules/Services/Security/Frigate/default.nix                # 网络录像服务
        # ./Modules/Services/Security/VaultWarden/default.nix            # 密码管理服务

        # 容器引擎
        ./Modules/Virtualisation/Docker/default.nix                    # Docker 引擎

        # 用户成员
        ./Users/ADMINISTRATION/default.nix                             # 行政部门
        ./Users/ANIMATION/default.nix                                  # 动画部门
        ./Users/BOARD/default.nix                                      # 董事会
        ./Users/BUSINESS/default.nix                                   # 商务部门
        ./Users/DESIGN/default.nix                                     # 设计部门
        ./Users/DEVELOPMENT/default.nix                                # 开发部门
        ./Users/FINANCE/default.nix                                    # 财务部门
        ./Users/VIDEO/default.nix                                      # 视频部门

        # 将所有 inputs 输入函数中所有的变量设为 home-manager 模块的特殊参数，这样 home-manager 子模块中可进行调用
        home-manager.extraSpecialArgs = { inherit inputs; };
        # 用户 home-manager（执行 nixos-rebuild switch 时，home-manager 配置会被自动部署）
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."0x0CFF" = {
            # ./Modules/Crates/Desktop/DE/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Explorer/Dotfiles/dotfiles.nix
            ./Modules/Crates/Operations/Terminal/Dotfiles/dotfiles.nix
          };
        };
      ]
    };
  };
}
