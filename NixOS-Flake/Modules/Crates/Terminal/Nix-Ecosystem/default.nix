{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    git                                              # [CLI] [C] 版本控制系统
    gitui                                            # [TUI] [RUST] Git 版本管理
    gitnr                                            # [TUI] [RUST] .gitignore 文件模板
    serie                                            # [TUI] [RUST] Git 分支提交图
    nh                                               # [AUX] [RUST] NixOS 生态辅助工具
    inputs.agenix.packages."${system}".default       # [CLI] [Nix] 信息加解密工具
  ];
  
  programs = {
    # 配置 Bash
    bash = {
      # Tab 补全功能
      completion.enable = true;
      # 在 Bash Shell 初始化期间调用的 Shell 脚本代码
      interactiveShellInit = ''
        bind '"\eg": "gitui\n"'
      '';
      # 设置命令别名
      shellAliases = {
        GIT = "git clone https://github.com/0x0CFF/NixOS-Studio.git ~/Solution/Blueprints/NixOS/NixOS-Studio";
        FLAKE = "sudo sh ~/Solution/Blueprints/NixOS/NixOS-Studio/Script/nixos-install.sh";
      };
    };
  };
}
