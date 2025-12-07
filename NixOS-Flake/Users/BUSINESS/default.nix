{ config, pkgs, inputs, ... }:

{
  users.users."BUSINESS_R0" = {
    isNormalUser = true;               # 是否为普通用户
    description = "商务部门-实习";       # 用户描述
    password = "WF457FQ7";
    group = "BUSINESS";                # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R0"
    ];
  };

  users.users."BUSINESS_R1" = {
    isNormalUser = true;               # 是否为普通用户
    description = "商务部门-初级";       # 用户描述
    password = "QPH3T2AS";
    group = "BUSINESS";                # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R1"
    ];
  };

  users.users."BUSINESS_R2" = {
    isNormalUser = true;               # 是否为普通用户
    description = "商务部门-中级";       # 用户描述
    password = "CYSMWAP3";
    group = "BUSINESS";                # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R2"
    ];
  };

  users.users."BUSINESS_R3" = {
    isNormalUser = true;               # 是否为普通用户
    description = "商务部门-高级";       # 用户描述
    password = "MJE3ZD86";
    group = "BUSINESS";                # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R3"
    ];
  };

  users.users."BUSINESS_R4" = {
    isNormalUser = true;               # 是否为普通用户
    description = "商务部门-主管";       # 用户描述
    password = "Q7CE3HGW";
    group = "BUSINESS";                # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R4"
    ];
  };

  users.users."BUSINESS_R5" = {
    isNormalUser = true;               # 是否为普通用户
    description = "商务部门-总监";       # 用户描述
    password = "SPCTYM37";
    group = "BUSINESS";                # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R5"
    ];
  };
}
