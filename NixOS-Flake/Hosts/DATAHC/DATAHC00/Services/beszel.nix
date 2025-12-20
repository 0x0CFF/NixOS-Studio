{ config, pkgs, inputs, ... }:

{
  services = {
    beszel.agent = {
      enable = true
      openFirewall = true
      environment = {   # 传递给 systemd 服务的环境变量
        #
      };
    };
  };
}