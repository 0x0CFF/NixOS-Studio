{ config, pkgs, inputs, ... }:

{
  services = {
    beszel.hub = {
      enable = true
      host = "0.0.0.0"
      port = 8090
      environment = {   # 传递给 systemd 服务的环境变量
        #
      };
    };
  };
}
