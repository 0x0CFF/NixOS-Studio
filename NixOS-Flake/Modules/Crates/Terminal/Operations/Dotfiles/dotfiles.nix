{ config, pkgs, inputs, ... }:let
  # 配置目录路径
  # ${config.home.homeDirectory} 表示 Home-Manager 管理的用户家目录
  bottomPath = "${config.home.homeDirectory}/Solution/Blueprints/NixOS/NixOS-Studio/NixOS-Flake/Modules/Crates/Operations/Terminal/Dotfiles/Bottom";
  naviPath = "${config.home.homeDirectory}/Solution/Blueprints/NixOS/NixOS-Studio/NixOS-Flake/Modules/Crates/Operations/Terminal/Dotfiles/Navi";
  zellijPath = "${config.home.homeDirectory}/Solution/Blueprints/NixOS/NixOS-Studio/NixOS-Flake/Modules/Crates/Operations/Terminal/Dotfiles/Zellij";
in
{
  # config.lib.file.mkOutOfStoreSymlink 可以创建一个指向 Dotfiles 绝对路径的软链接
  # 该函数能够绕过 Home Manager 自身，对 Dotfiles 的修改就能立即生效
  # 注意：仅支持原生配置，由 Nix 生成的配置不支持
  xdg.configFile."bottom".source = config.lib.file.mkOutOfStoreSymlink bottomPath;
  xdg.configFile."navi".source = config.lib.file.mkOutOfStoreSymlink naviPath;
  xdg.configFile."starship.toml".source = ./Starship/starship.toml;
  xdg.configFile."zellij".source = config.lib.file.mkOutOfStoreSymlink zellijPath;
}
