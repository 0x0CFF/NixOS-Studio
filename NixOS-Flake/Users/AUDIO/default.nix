{ config, pkgs, inputs, ... }:

{
  users.users."AUDIO_R0" = {
    isNormalUser = true;               # 是否为普通用户
    description = "音频部门-实习";       # 用户描述
    password = "QGZM6FQA";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "AUDIO"
      "R0"
    ];
  };

  users.users."AUDIO_R1" = {
    isNormalUser = true;               # 是否为普通用户
    description = "音频部门-初级";       # 用户描述
    password = "NRB6RHGF";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "AUDIO"
      "R1"
    ];
  };

  users.users."AUDIO_R2" = {
    isNormalUser = true;               # 是否为普通用户
    description = "音频部门-中级";       # 用户描述
    password = "RZF3R4NS";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "AUDIO"
      "R2"
    ];
  };

  users.users."AUDIO_R3" = {
    isNormalUser = true;               # 是否为普通用户
    description = "音频部门-高级";       # 用户描述
    password = "G4VHBJ4Z";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "AUDIO"
      "R3"
    ];
  };

  users.users."AUDIO_R4" = {
    isNormalUser = true;               # 是否为普通用户
    description = "音频部门-主管";       # 用户描述
    password = "E5QHSHUD";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "AUDIO"
      "R4"
    ];
  };

  users.users."AUDIO_R5" = {
    isNormalUser = true;               # 是否为普通用户
    description = "音频部门-总监";       # 用户描述
    password = "HSN4RFWQ";
    group = "STUDIO";                  # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "AUDIO"
      "R5"
    ];
  };
}
