{ config, pkgs, inputs, ... }:

{
  users.users."OPERATION_R0" = {
    isNormalUser = true;               # 是否为普通用户
    description = "运维部门-实习";       # 用户描述
    password = "WM3E8FZ4";
    group = "OPERATION";               # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R0"
    ];
  };

  users.users."OPERATION_R1" = {
    isNormalUser = true;               # 是否为普通用户
    description = "运维部门-初级";       # 用户描述
    password = "WF5ZPXW8";
    group = "OPERATION";               # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R1"
    ];
  };

  users.users."OPERATION_R2" = {
    isNormalUser = true;               # 是否为普通用户
    description = "运维部门-中级";       # 用户描述
    password = "C56UA3NK";
    group = "OPERATION";               # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R2"
    ];
  };

  users.users."OPERATION_R3" = {
    isNormalUser = true;               # 是否为普通用户
    description = "运维部门-高级";       # 用户描述
    password = "V4KQZ4CZ";
    group = "OPERATION";               # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R3"
    ];
  };

  users.users."OPERATION_R4" = {
    isNormalUser = true;               # 是否为普通用户
    description = "运维部门-主管";       # 用户描述
    password = "WN8W6DZS";
    group = "OPERATION";               # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R4"
    ];
  };

  users.users."OPERATION_R5" = {
    isNormalUser = true;               # 是否为普通用户
    description = "运维部门-总监";       # 用户描述
    password = "B6XCURH4";
    group = "OPERATION";               # 主要用户组
    extraGroups = [                    # 辅助用户组
      "PUBLIC"
      "R5"
    ];
  };
}
