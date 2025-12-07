{ config, pkgs, inputs, ... }:

{
  users.users."DEVELOPMENT_R0" = {
    isNormalUser = true;               # 是否为普通用户
    description = "开发部门-实习";       # 用户描述
    password = "PGNJTZ6V";
    group = "DEVELOPMENT";             # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R0"
    ];
  };

  users.users."DEVELOPMENT_R1" = {
    isNormalUser = true;               # 是否为普通用户
    description = "开发部门-初级";       # 用户描述
    password = "GD4GEAVQ";
    group = "DEVELOPMENT";             # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R1"
    ];
  };

  users.users."DEVELOPMENT_R2" = {
    isNormalUser = true;               # 是否为普通用户
    description = "开发部门-中级";       # 用户描述
    password = "T6TW7BFQ";
    group = "DEVELOPMENT";             # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R2"
    ];
  };

  users.users."DEVELOPMENT_R3" = {
    isNormalUser = true;               # 是否为普通用户
    description = "开发部门-高级";       # 用户描述
    password = "NSN8G7R4";
    group = "DEVELOPMENT";             # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R3"
    ];
  };

  users.users."DEVELOPMENT_R4" = {
    isNormalUser = true;               # 是否为普通用户
    description = "开发部门-主管";       # 用户描述
    password = "NRACA2MJ";
    group = "DEVELOPMENT";             # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R4"
    ];
  };

  users.users."DEVELOPMENT_R5" = {
    isNormalUser = true;               # 是否为普通用户
    description = "开发部门-总监";       # 用户描述
    password = "MGCT6JK6";
    group = "DEVELOPMENT";             # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R5"
    ];
  };
}
