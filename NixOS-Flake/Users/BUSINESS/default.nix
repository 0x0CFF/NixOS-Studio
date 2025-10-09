{ config, pkgs, inputs, ... }:

{
  users.users."BUSINESS_R0" = {
    isNormalUser = false;              # 是否为真实用户
    description = "商务部门-实习";       # 用户描述
    password = "WF457FQ7";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "BUSINESS"
      "R0"
    ];
  };

  users.users."BUSINESS_R1" = {
    isNormalUser = false;              # 是否为真实用户
    description = "商务部门-初级";       # 用户描述
    password = "QPH3T2AS";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "BUSINESS"
      "R1"
    ];
  };

  users.users."BUSINESS_R2" = {
    isNormalUser = false;              # 是否为真实用户
    description = "商务部门-中级";       # 用户描述
    password = "CYSMWAP3";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "BUSINESS"
      "R2"
    ];
  };

  users.users."BUSINESS_R3" = {
    isNormalUser = false;              # 是否为真实用户
    description = "商务部门-高级";       # 用户描述
    password = "MJE3ZD86";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "BUSINESS"
      "R3"
    ];
  };

  users.users."BUSINESS_R4" = {
    isNormalUser = false;              # 是否为真实用户
    description = "商务部门-主管";       # 用户描述
    password = "Q7CE3HGW";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "BUSINESS"
      "R4"
    ];
  };

  users.users."BUSINESS_R5" = {
    isNormalUser = false;              # 是否为真实用户
    description = "商务部门-总监";       # 用户描述
    password = "SPCTYM37";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "BUSINESS"
      "R5"
    ];
  };
}
