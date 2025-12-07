{ config, pkgs, inputs, ... }:

{
  users.users."EFFECTS_R0" = {
    isNormalUser = true;               # 是否为普通用户
    description = "特效部门-实习";       # 用户描述
    password = "QGZM6FQA";
    group = "EFFECTS";                 # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R0"
    ];
  };

  users.users."EFFECTS_R1" = {
    isNormalUser = true;               # 是否为普通用户
    description = "特效部门-初级";       # 用户描述
    password = "NRB6RHGF";
    group = "EFFECTS";                 # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R1"
    ];
  };

  users.users."EFFECTS_R2" = {
    isNormalUser = true;               # 是否为普通用户
    description = "特效部门-中级";       # 用户描述
    password = "RZF3R4NS";
    group = "EFFECTS";                 # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R2"
    ];
  };

  users.users."EFFECTS_R3" = {
    isNormalUser = true;               # 是否为普通用户
    description = "特效部门-高级";       # 用户描述
    password = "G4VHBJ4Z";
    group = "EFFECTS";                 # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R3"
    ];
  };

  users.users."EFFECTS_R4" = {
    isNormalUser = true;               # 是否为普通用户
    description = "特效部门-主管";       # 用户描述
    password = "E5QHSHUD";
    group = "EFFECTS";                 # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R4"
    ];
  };

  users.users."EFFECTS_R5" = {
    isNormalUser = true;               # 是否为普通用户
    description = "特效部门-总监";       # 用户描述
    password = "HSN4RFWQ";
    group = "EFFECTS";                 # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R5"
    ];
  };
}
