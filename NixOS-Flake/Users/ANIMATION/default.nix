{ config, pkgs, inputs, ... }:

{
  users.users."ANIMATION_R0" = {
    isNormalUser = true;               # 是否为普通用户
    description = "动画部门-实习";       # 用户描述
    password = "HG7G3R37";
    group = "ANIMATION";               # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R0"
    ];
  };

  users.users."ANIMATION_R1" = {
    isNormalUser = true;               # 是否为普通用户
    description = "动画部门-初级";       # 用户描述
    password = "MWN8JYM6";
    group = "ANIMATION";               # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R1"
    ];
  };

  users.users."ANIMATION_R2" = {
    isNormalUser = true;               # 是否为普通用户
    description = "动画部门-中级";       # 用户描述
    password = "DH3J5M4J";
    group = "ANIMATION";               # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R2"
    ];
  };

  users.users."ANIMATION_R3" = {
    isNormalUser = true;               # 是否为普通用户
    description = "动画部门-高级";       # 用户描述
    password = "H9HVFY6N";
    group = "ANIMATION";               # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R3"
    ];
  };

  users.users."ANIMATION_R4" = {
    isNormalUser = true;               # 是否为普通用户
    description = "动画部门-主管";       # 用户描述
    password = "CDF7VG4X";
    group = "ANIMATION";               # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R4"
    ];
  };

  users.users."ANIMATION_R5" = {
    isNormalUser = true;               # 是否为普通用户
    description = "动画部门-总监";       # 用户描述
    password = "AUS38NTL";
    group = "ANIMATION";               # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R5"
    ];
  };
}
