{ config, pkgs, inputs, ... }:

{
  users.users."DESIGN_R0" = {
    isNormalUser = true;               # 是否为普通用户
    description = "设计部门-实习";       # 用户描述
    password = "K68N4GEH";
    group = "DESIGN";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R0"
    ];
  };

  users.users."DESIGN_R1" = {
    isNormalUser = true;               # 是否为普通用户
    description = "设计部门-初级";       # 用户描述
    password = "GEK26RBW";
    group = "DESIGN";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R1"
    ];
  };

  users.users."DESIGN_R2" = {
    isNormalUser = true;               # 是否为普通用户
    description = "设计部门-中级";       # 用户描述
    password = "CPSFB7PK";
    group = "DESIGN";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R2"
    ];
  };

  users.users."DESIGN_R3" = {
    isNormalUser = true;               # 是否为普通用户
    description = "设计部门-高级";       # 用户描述
    password = "QDY7SBK3";
    group = "DESIGN";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R3"
    ];
  };

  users.users."DESIGN_R4" = {
    isNormalUser = true;               # 是否为普通用户
    description = "设计部门-主管";       # 用户描述
    password = "RY82N8JX";
    group = "DESIGN";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R4"
    ];
  };

  users.users."DESIGN_R5" = {
    isNormalUser = true;               # 是否为普通用户
    description = "设计部门-总监";       # 用户描述
    password = "PHRA45FF";
    group = "DESIGN";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R5"
    ];
  };
}
