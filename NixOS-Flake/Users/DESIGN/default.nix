{ config, pkgs, inputs, ... }:

{
  users.users."DESIGN_R0" = {
    isNormalUser = false;              # 是否为真实用户
    description = "设计部门-实习";       # 用户描述
    password = "K68N4GEH";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "DESIGN"
      "R0"
    ];
  };

  users.users."DESIGN_R1" = {
    isNormalUser = false;              # 是否为真实用户
    description = "设计部门-初级";       # 用户描述
    password = "GEK26RBW";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "DESIGN"
      "R1"
    ];
  };

  users.users."DESIGN_R2" = {
    isNormalUser = false;              # 是否为真实用户
    description = "设计部门-中级";       # 用户描述
    password = "CPSFB7PK";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "DESIGN"
      "R2"
    ];
  };

  users.users."DESIGN_R3" = {
    isNormalUser = false;              # 是否为真实用户
    description = "设计部门-高级";       # 用户描述
    password = "QDY7SBK3";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "DESIGN"
      "R3"
    ];
  };

  users.users."DESIGN_R4" = {
    isNormalUser = false;              # 是否为真实用户
    description = "设计部门-主管";       # 用户描述
    password = "RY82N8JX";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "DESIGN"
      "R4"
    ];
  };

  users.users."DESIGN_R5" = {
    isNormalUser = false;              # 是否为真实用户
    description = "设计部门-总监";       # 用户描述
    password = "PHRA45FF";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "DESIGN"
      "R5"
    ];
  };
}
