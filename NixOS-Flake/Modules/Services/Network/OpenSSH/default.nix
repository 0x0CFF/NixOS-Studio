{ config, pkgs, inputs, ... }:

{
  services = {
    openssh = {
      enable = true;
      openFirewall = true;     # 开放防火墙端口
      settings = {
        # 访问控制，用户登录白名单
        AllowUsers = [
          "0x0CFF@192.168.31.*"
        ];
        # Root 用户是否可以登录，共有 6 种
        # null                   : 无
        # "yes"                  : 允许 Root 用户登录，需要密码验证
        # "without-password"     : 允许 Root 用户登录，不需要密码验证
        # "prohibit-password"    : 允许 Root 用户登录，需要密码验证
        # "forced-commands-only" : 允许 Root 用户登录，仅允许使用密钥
        # "no"                   : 不允许 Root 用户登录
        PermitRootLogin = "no";
      };
    };
  };
}
