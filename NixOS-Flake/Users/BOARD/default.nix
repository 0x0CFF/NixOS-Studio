{ config, pkgs, inputs, ... }:

{
  users.users."BOARD_R0" = {
    isNormalUser = true;               # 是否为普通用户
    description = "董事秘书-实习";       # 用户描述
    password = "EN35TSUX";
    group = "BOARD";                   # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R0"
    ];
  };

  users.users."BOARD_R1" = {
    isNormalUser = true;               # 是否为普通用户
    description = "董事秘书-正式";       # 用户描述
    password = "TN4F8YLH";
    group = "BOARD";                   # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R1"
    ];
  };

  users.users."BOARD_R2" = {
    isNormalUser = true;               # 是否为普通用户
    description = "董事成员";           # 用户描述
    password = "GBNE26R7";
    group = "BOARD";                   # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R2"
    ];
  };

  users.users."BOARD_R3" = {
    isNormalUser = true;               # 是否为普通用户
    description = "执行董事";           # 用户描述
    password = "F7EY6KJM";
    group = "BOARD";                   # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R3"
    ];
  };

  users.users."BOARD_R4" = {
    isNormalUser = true;               # 是否为普通用户
    description = "副董事长";           # 用户描述
    password = "M5LF7M65";
    group = "BOARD";                   # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R4"
    ];
  };

  users.users."BOARD_R5" = {
    isNormalUser = true;               # 是否为普通用户
    description = "董事长";             # 用户描述
    password = "A8HFKF8M";
    group = "BOARD";                   # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R5"
    ];
  };
}
