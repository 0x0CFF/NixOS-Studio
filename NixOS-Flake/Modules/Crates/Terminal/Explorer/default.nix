{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    wl-clipboard-rs          # [AUX] [RUST] 剪贴板
    zoxide                   # [AUX] [RUST] 快速 cd 命令
    fd                       # [CLI] [RUST] 文件查找工具
    trashy                   # [CLI] [RUST] 命令行回收站工具
    fzf                      # [CLI] [GO] 模糊查找器
    ouch                     # [CLI] [RUST] 解压缩工具
    ripgrep                  # [CLI] [RUST] 文件内容查找工具
    helix                    # [TUI] [RUST] 文本编辑器
    yazi                     # [TUI] [RUST] 文件管理器
  ];

  programs = {
    # 配置 Bash
    bash = {
      # 在 Bash Shell 初始化期间调用的 Shell 脚本代码
      interactiveShellInit = ''
        bind '"\ee": "yazi\n"'
      '';
    };
  };
}
