{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    bc                       # [AUX] [BC] 任意精度计算工具
    tailspin                 # [AUX] [RUST] 日志文件高亮工具
    starship                 # [AUX] [RUST] 命令行提示符
    eza                      # [AUX] [RUST] 文件列表命令行
    curl                     # [CLI] [C] URL 传输数据
    fastfetch                # [CLI] [C] 系统信息查看工具
    openssl                  # [CLI] [C] SSL/TLS 协议加密库
    grex                     # [CLI] [RUST] 正则表达式生成器
    bottom                   # [TUI] [RUST] 资源管理器
    zellij                   # [TUI] [RUST] 终端复用器
    pik                      # [TUI] [RUST] 进程交互式 Kill 工具
    navi                     # [TUI] [RUST] 命令行交互式备忘单工具
    systemctl-tui            # [TUI] [RUST] Systemd 服务管理工具
  ];
  
  programs = {
    # 配置 Bash
    bash = {
      # Tab 补全功能
      completion.enable = true;
      # 在 Bash Shell 初始化期间调用的 Shell 脚本代码
      interactiveShellInit = ''
        eval "$(starship init bash)"
        eval "$(navi widget bash)"
        eval "$(zellij setup --generate-auto-start bash)"
        bind '"\eq": "navi --path ~/.config/navi\n"'
        bind '"\ec": clear-screen'
        bind '"\en": "fastfetch\n"'
        bind '"\em": "btm\n"'
        bind '"\ek": "pik\n"'
        bind '"\es": "systemctl-tui\n"'
      '';
      # 设置命令别名
      shellAliases = {
        NAVI = "navi --path '~/.config/navi'";
      };
    };
  };
}
