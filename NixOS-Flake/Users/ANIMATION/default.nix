{ config, pkgs, inputs, ... }:

{
  users.users."ANIMATION_R0" = {
    isNormalUser = false;              # 是否为真实用户
    description = "动画部门-实习";       # 用户描述
    password = "HG7G3R37";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "ANIMATION"
      "R0"
    ];
  };

  users.users."ANIMATION_R1" = {
    isNormalUser = false;              # 是否为真实用户
    description = "动画部门-初级";       # 用户描述
    password = "MWN8JYM6";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "ANIMATION"
      "R1"
    ];
  };

  users.users."ANIMATION_R2" = {
    isNormalUser = false;              # 是否为真实用户
    description = "动画部门-中级";       # 用户描述
    password = "DH3J5M4J";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "ANIMATION"
      "R2"
    ];
  };

  users.users."ANIMATION_R3" = {
    isNormalUser = false;              # 是否为真实用户
    description = "动画部门-高级";       # 用户描述
    password = "H9HVFY6N";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "ANIMATION"
      "R3"
    ];
  };

  users.users."ANIMATION_R4" = {
    isNormalUser = false;              # 是否为真实用户
    description = "动画部门-主管";       # 用户描述
    password = "CDF7VG4X";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "ANIMATION"
      "R4"
    ];
  };

  users.users."ANIMATION_R5" = {
    isNormalUser = false;              # 是否为真实用户
    description = "动画部门-总监";       # 用户描述
    password = "AUS38NTL";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "ANIMATION"
      "R5"
    ];
  };
}
