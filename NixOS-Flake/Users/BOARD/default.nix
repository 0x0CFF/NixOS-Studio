{ config, pkgs, inputs, ... }:

{
  users.users."BOARD_R0" = {
    isNormalUser = false;              # 是否为真实用户
    description = "董事秘书-实习";       # 用户描述
    password = "EN35TSUX";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "BOARD"
      "R0"
    ];
  };

  users.users."BOARD_R1" = {
    isNormalUser = false;              # 是否为真实用户
    description = "董事秘书-正式";       # 用户描述
    password = "TN4F8YLH";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "BOARD"
      "R1"
    ];
  };

  users.users."BOARD_R2" = {
    isNormalUser = false;              # 是否为真实用户
    description = "董事成员";           # 用户描述
    password = "GBNE26R7";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "BOARD"
      "R2"
    ];
  };

  users.users."BOARD_R3" = {
    isNormalUser = false;              # 是否为真实用户
    description = "执行董事";           # 用户描述
    password = "F7EY6KJM";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "BOARD"
      "R3"
    ];
  };

  users.users."BOARD_R4" = {
    isNormalUser = false;              # 是否为真实用户
    description = "副董事长";           # 用户描述
    password = "M5LF7M65";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "BOARD"
      "R4"
    ];
  };

  users.users."BOARD_R5" = {
    isNormalUser = false;              # 是否为真实用户
    description = "董事长";             # 用户描述
    password = "A8HFKF8M";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "BOARD"
      "R5"
    ];
  };
}
