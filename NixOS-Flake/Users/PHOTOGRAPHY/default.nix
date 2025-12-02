{ config, pkgs, inputs, ... }:

{
  users.users."PHOTOGRAPHY_R0" = {
    isNormalUser = true;               # 是否为普通用户
    description = "摄影部门-实习";       # 用户描述
    password = "RD528VP5";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "PHOTOGRAPHY"
      "R0"
    ];
  };

  users.users."PHOTOGRAPHY_R1" = {
    isNormalUser = true;               # 是否为普通用户
    description = "摄影部门-初级";       # 用户描述
    password = "VNU2YR76";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "PHOTOGRAPHY"
      "R1"
    ];
  };

  users.users."PHOTOGRAPHY_R2" = {
    isNormalUser = true;               # 是否为普通用户
    description = "摄影部门-中级";       # 用户描述
    password = "USKSN4AB";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "PHOTOGRAPHY"
      "R2"
    ];
  };

  users.users."PHOTOGRAPHY_R3" = {
    isNormalUser = true;               # 是否为普通用户
    description = "摄影部门-高级";       # 用户描述
    password = "H4N4NZB3";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "PHOTOGRAPHY"
      "R3"
    ];
  };

  users.users."PHOTOGRAPHY_R4" = {
    isNormalUser = true;               # 是否为普通用户
    description = "摄影部门-主管";       # 用户描述
    password = "NKXJZ34B";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "PHOTOGRAPHY"
      "R4"
    ];
  };

  users.users."PHOTOGRAPHY_R5" = {
    isNormalUser = true;               # 是否为普通用户
    description = "摄影部门-总监";       # 用户描述
    password = "RGJ8A8UM";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "PHOTOGRAPHY"
      "R5"
    ];
  };
}
