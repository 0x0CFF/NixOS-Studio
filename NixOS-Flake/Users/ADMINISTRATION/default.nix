{ config, pkgs, inputs, ... }:

{
  users.users."ADMINISTRATION_R0" = {
    isNormalUser = false;              # 是否为真实用户
    description = "行政部门-实习";       # 用户描述
    password = "K2NGW84T";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "ADMINISTRATION"
      "R0"
    ];
  };

  users.users."ADMINISTRATION_R1" = {
    isNormalUser = false;              # 是否为真实用户
    description = "行政部门-初级";       # 用户描述
    password = "CRKNF72C";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "ADMINISTRATION"
      "R1"
    ];
  };

  users.users."ADMINISTRATION_R2" = {
    isNormalUser = false;              # 是否为真实用户
    description = "行政部门-中级";       # 用户描述
    password = "ZEYM4DMN";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "ADMINISTRATION"
      "R2"
    ];
  };

  users.users."ADMINISTRATION_R3" = {
    isNormalUser = false;              # 是否为真实用户
    description = "行政部门-高级";       # 用户描述
    password = "PA9QF9Q3";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "ADMINISTRATION"
      "R3"
    ];
  };

  users.users."ADMINISTRATION_R4" = {
    isNormalUser = false;              # 是否为真实用户
    description = "行政部门-主管";       # 用户描述
    password = "Y7BWEU3N";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "ADMINISTRATION"
      "R4"
    ];
  };

  users.users."ADMINISTRATION_R5" = {
    isNormalUser = false;              # 是否为真实用户
    description = "行政部门-总监";       # 用户描述
    password = "Y87GKEHJ";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "ADMINISTRATION"
      "R5"
    ];
  };
}
