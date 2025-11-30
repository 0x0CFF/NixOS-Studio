{ config, pkgs, inputs, ... }:

{
  users.users."FINANCE_R0" = {
    isNormalUser = true;               # 是否为普通用户
    description = "财务部门-实习";       # 用户描述
    password = "G35EXZYC";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "FINANCE"
      "R0"
    ];
  };

  users.users."FINANCE_R1" = {
    isNormalUser = true;               # 是否为普通用户
    description = "财务部门-初级";       # 用户描述
    password = "Q2HSA5ZX";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "FINANCE"
      "R1"
    ];
  };

  users.users."FINANCE_R2" = {
    isNormalUser = true;               # 是否为普通用户
    description = "财务部门-中级";       # 用户描述
    password = "FE5R29QY";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "FINANCE"
      "R2"
    ];
  };

  users.users."FINANCE_R3" = {
    isNormalUser = true;               # 是否为普通用户
    description = "财务部门-高级";       # 用户描述
    password = "D78RZQDX";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "FINANCE"
      "R3"
    ];
  };

  users.users."FINANCE_R4" = {
    isNormalUser = true;               # 是否为普通用户
    description = "财务部门-主管";       # 用户描述
    password = "DQ92FXRF";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "FINANCE"
      "R4"
    ];
  };

  users.users."FINANCE_R5" = {
    isNormalUser = true;               # 是否为普通用户
    description = "财务部门-总监";       # 用户描述
    password = "F28MF8LU";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "FINANCE"
      "R5"
    ];
  };
}
