{ config, pkgs, inputs, ... }:

{
  users.users."PHOTOGRAPHY_R0" = {
    isNormalUser = true;               # 是否为普通用户
    description = "摄影部门-实习";       # 用户描述
    password = "RD528VP5";
    group = "PHOTOGRAPHY";             # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R0"
    ];
  };

  users.users."PHOTOGRAPHY_R1" = {
    isNormalUser = true;               # 是否为普通用户
    description = "摄影部门-初级";       # 用户描述
    password = "VNU2YR76";
    group = "PHOTOGRAPHY";             # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R1"
    ];
  };

  users.users."PHOTOGRAPHY_R2" = {
    isNormalUser = true;               # 是否为普通用户
    description = "摄影部门-中级";       # 用户描述
    password = "USKSN4AB";
    group = "PHOTOGRAPHY";             # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R2"
    ];
  };

  users.users."PHOTOGRAPHY_R3" = {
    isNormalUser = true;               # 是否为普通用户
    description = "摄影部门-高级";       # 用户描述
    password = "H4N4NZB3";
    group = "PHOTOGRAPHY";             # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R3"
    ];
  };

  users.users."PHOTOGRAPHY_R4" = {
    isNormalUser = true;               # 是否为普通用户
    description = "摄影部门-主管";       # 用户描述
    password = "NKXJZ34B";
    group = "PHOTOGRAPHY";             # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R4"
    ];
  };

  users.users."PHOTOGRAPHY_R5" = {
    isNormalUser = true;               # 是否为普通用户
    description = "摄影部门-总监";       # 用户描述
    password = "RGJ8A8UM";
    group = "PHOTOGRAPHY";             # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R5"
    ];
  };
}
