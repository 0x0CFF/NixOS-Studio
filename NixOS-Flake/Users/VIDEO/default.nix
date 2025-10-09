{ config, pkgs, inputs, ... }:

{
  users.users."VIDEO_R0" = {
    isNormalUser = false;              # 是否为真实用户
    description = "视频部门-实习";       # 用户描述
    password = "K3GTMT5E";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "VIDEO"
      "R0"
    ];
  };

  users.users."VIDEO_R1" = {
    isNormalUser = false;              # 是否为真实用户
    description = "视频部门-初级";       # 用户描述
    password = "F5SVQF9K";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "VIDEO"
      "R1"
    ];
  };
  
  users.users."VIDEO_R2" = {
    isNormalUser = false;              # 是否为真实用户
    description = "视频部门-中级";       # 用户描述
    password = "HG4KZ6NB";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "VIDEO"
      "R2"
    ];
  };
  
  users.users."VIDEO_R3" = {
    isNormalUser = false;              # 是否为真实用户
    description = "视频部门-高级";       # 用户描述
    password = "DU5NE8RJ";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "VIDEO"
      "R3"
    ];
  };
  
  users.users."VIDEO_R4" = {
    isNormalUser = false;              # 是否为真实用户
    description = "视频部门-主管";       # 用户描述
    password = "JMJU77CB";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "VIDEO"
      "R4"
    ];
  };
  
  users.users."VIDEO_R5" = {
    isNormalUser = false;              # 是否为真实用户
    description = "视频部门-总监";       # 用户描述
    password = "X73D32ZF";
    group = [                          # 主要用户组
      # "users"
    ];
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "VIDEO"
      "R5"
    ];
  };
}
