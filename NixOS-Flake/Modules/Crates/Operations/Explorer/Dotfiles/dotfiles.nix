{ config, pkgs, inputs, ... }:let
  # 配置目录路径
  # ${config.home.homeDirectory} 表示 Home-Manager 管理的用户家目录
  helixPath = "${config.home.homeDirectory}/Solution/Blueprints/NixOS/NixOS-Studio/NixOS-Flake/Modules/Crates/Operations/Explorer/Dotfiles/Helix";
  yaziPath = "${config.home.homeDirectory}/Solution/Blueprints/NixOS/NixOS-Studio/NixOS-Flake/Modules/Crates/Operations/Explorer/Dotfiles/Yazi";
in
{
  # config.lib.file.mkOutOfStoreSymlink 可以创建一个指向 Dotfiles 绝对路径的软链接
  # 该函数能够绕过 Home Manager 自身，对 Dotfiles 的修改就能立即生效
  # 注意：仅支持原生配置，由 Nix 生成的配置不支持
  xdg.configFile."helix".source = config.lib.file.mkOutOfStoreSymlink helixPath;
  xdg.configFile."yazi".source = config.lib.file.mkOutOfStoreSymlink yaziPath;
}