{ config, pkgs, inputs, ... }:

{
  users.users."ADMINISTRATION_R0" = {
    isNormalUser = true;               # 是否为普通用户
    description = "行政部门-实习";       # 用户描述
    password = "K2NGW84T";
    group = "ADMINISTRATION";          # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R0"
    ];
  };

  users.users."ADMINISTRATION_R1" = {
    isNormalUser = true;               # 是否为普通用户
    description = "行政部门-初级";       # 用户描述
    password = "CRKNF72C";
    group = "ADMINISTRATION";          # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R1"
    ];
  };

  users.users."ADMINISTRATION_R2" = {
    isNormalUser = true;               # 是否为普通用户
    description = "行政部门-中级";       # 用户描述
    password = "ZEYM4DMN";
    group = "ADMINISTRATION";          # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R2"
    ];
  };

  users.users."ADMINISTRATION_R3" = {
    isNormalUser = true;               # 是否为普通用户
    description = "行政部门-高级";       # 用户描述
    password = "PA9QF9Q3";
    group = "ADMINISTRATION";          # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R3"
    ];
  };

  users.users."ADMINISTRATION_R4" = {
    isNormalUser = true;               # 是否为普通用户
    description = "行政部门-主管";       # 用户描述
    password = "Y7BWEU3N";
    group = "ADMINISTRATION";          # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R4"
    ];
  };

  users.users."ADMINISTRATION_R5" = {
    isNormalUser = true;               # 是否为普通用户
    description = "行政部门-总监";       # 用户描述
    password = "Y87GKEHJ";
    group = "ADMINISTRATION";          # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R5"
    ];
  };
}
