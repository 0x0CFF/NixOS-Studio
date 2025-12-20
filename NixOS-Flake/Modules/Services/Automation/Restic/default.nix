{ config, pkgs, inputs, ... }:

{
  services = {
    restic.server = {
      enable = true;
      listenAddress = "127.0.0.1:9999";
      # 传递给 Restic REST 服务器的额外命令行选项
      extraFlags = [
        #
      ];
    };
  };
}