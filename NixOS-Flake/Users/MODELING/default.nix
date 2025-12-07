{ config, pkgs, inputs, ... }:

{
  users.users."MODELING_R0" = {
    isNormalUser = true;               # 是否为普通用户
    description = "建模部门-实习";       # 用户描述
    password = "N76RBDGS";
    group = "MODELING";                # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R0"
    ];
  };

  users.users."MODELING_R1" = {
    isNormalUser = true;               # 是否为普通用户
    description = "建模部门-初级";       # 用户描述
    password = "KT4V2NPV";
    group = "MODELING";                # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R1"
    ];
  };

  users.users."MODELING_R2" = {
    isNormalUser = true;               # 是否为普通用户
    description = "建模部门-中级";       # 用户描述
    password = "HWJS87K7";
    group = "MODELING";                # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R2"
    ];
  };

  users.users."MODELING_R3" = {
    isNormalUser = true;               # 是否为普通用户
    description = "建模部门-高级";       # 用户描述
    password = "WJC4WSEH";
    group = "MODELING";                # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R3"
    ];
  };

  users.users."MODELING_R4" = {
    isNormalUser = true;               # 是否为普通用户
    description = "建模部门-主管";       # 用户描述
    password = "VNH5DS48";
    group = "MODELING";                # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R4"
    ];
  };

  users.users."MODELING_R5" = {
    isNormalUser = true;               # 是否为普通用户
    description = "建模部门-总监";       # 用户描述
    password = "KQ64FZ8R";
    group = "MODELING";                # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R5"
    ];
  };
}
