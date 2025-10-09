{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    git                      # [C] [CLI] 版本控制系统
    gitui                    # [TUI] [RUST] Git 版本管理
    gitnr                    # [TUI] [RUST] .gitignore 文件模板
    serie                    # [TUI] [RUST] Git 分支提交图
  ];
}
