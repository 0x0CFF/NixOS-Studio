{ config, pkgs, inputs, ... }:

{
  users.users."DEVELOPMENT_R0" = {
    isNormalUser = false;              # 是否为真实用户
    description = "开发部门-实习";       # 用户描述
    password = "PGNJTZ6V";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "DEVELOPMENT"
      "R0"
    ];
  };

  users.users."DEVELOPMENT_R1" = {
    isNormalUser = false;              # 是否为真实用户
    description = "开发部门-初级";       # 用户描述
    password = "GD4GEAVQ";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "DEVELOPMENT"
      "R1"
    ];
  };

  users.users."DEVELOPMENT_R2" = {
    isNormalUser = false;              # 是否为真实用户
    description = "开发部门-中级";       # 用户描述
    password = "T6TW7BFQ";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "DEVELOPMENT"
      "R2"
    ];
  };

  users.users."DEVELOPMENT_R3" = {
    isNormalUser = false;              # 是否为真实用户
    description = "开发部门-高级";       # 用户描述
    password = "NSN8G7R4";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "DEVELOPMENT"
      "R3"
    ];
  };

  users.users."DEVELOPMENT_R4" = {
    isNormalUser = false;              # 是否为真实用户
    description = "开发部门-主管";       # 用户描述
    password = "NRACA2MJ";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "DEVELOPMENT"
      "R4"
    ];
  };

  users.users."DEVELOPMENT_R5" = {
    isNormalUser = false;              # 是否为真实用户
    description = "开发部门-总监";       # 用户描述
    password = "MGCT6JK6";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "DEVELOPMENT"
      "R5"
    ];
  };
}
