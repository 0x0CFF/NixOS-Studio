{ config, pkgs, inputs, ... }:

{
  users.users."VIDEO_R0" = {
    isNormalUser = true;               # 是否为普通用户
    description = "视频部门-实习";       # 用户描述
    password = "K3GTMT5E";
    group = "VIDEO";                   # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R0"
    ];
  };

  users.users."VIDEO_R1" = {
    isNormalUser = true;               # 是否为普通用户
    description = "视频部门-初级";       # 用户描述
    password = "F5SVQF9K";
    group = "VIDEO";                   # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R1"
    ];
  };
  
  users.users."VIDEO_R2" = {
    isNormalUser = true;               # 是否为普通用户
    description = "视频部门-中级";       # 用户描述
    password = "HG4KZ6NB";
    group = "VIDEO";                   # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R2"
    ];
  };
  
  users.users."VIDEO_R3" = {
    isNormalUser = true;               # 是否为普通用户
    description = "视频部门-高级";       # 用户描述
    password = "DU5NE8RJ";
    group = "VIDEO";                   # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R3"
    ];
  };
  
  users.users."VIDEO_R4" = {
    isNormalUser = true;               # 是否为普通用户
    description = "视频部门-主管";       # 用户描述
    password = "JMJU77CB";
    group = "VIDEO";                   # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R4"
    ];
  };
  
  users.users."VIDEO_R5" = {
    isNormalUser = true;               # 是否为普通用户
    description = "视频部门-总监";       # 用户描述
    password = "X73D32ZF";
    group = "VIDEO";                   # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R5"
    ];
  };
}
