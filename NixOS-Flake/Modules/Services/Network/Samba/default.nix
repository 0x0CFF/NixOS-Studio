{ config, pkgs, inputs, ... }:

{
  services = {
    samba = {
      enable = true;
      openFirewall = true;     # 开放防火墙端口
      settings = {
        # 全局配置
        global = {
          # 设定安全级别，共有 6 种
          # share  : 不需要提供用户名和密码
          # user   : 需要提供用户名和密码，身份验证由 Samba 负责
          # server : 需要提供用户名和密码，可指定其他机器作身份验证
          # domain : 需要提供用户名和密码，指定域服务器作身份验证
          security = "user";
          # 用户登录黑名单
          "invalid users" = [
            "root"
            "0x0CFF"
          ];
        };
      };
    };
    # Web 服务动态发现主机守护程序，使共享对 Windows 10 客户端可见
    # 这使 Samba 主机（如本地 NAS 设备）能够被 Windows 等 Web 服务发现客户端找到
    samba-wsdd = {
      enable = true;                                  # 启用服务
      workgroup = "WORKGROUP";                        # Samba 工作组
    };
  };
}
