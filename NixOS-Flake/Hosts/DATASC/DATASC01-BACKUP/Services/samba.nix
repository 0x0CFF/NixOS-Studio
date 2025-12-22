{ config, pkgs, inputs, ... }:

{
  services.samba-wsdd = {
    # Samba 工作组
    workgroup = "WORKGROUP";
    # Samba 服务器名称
    hostname = "DATASC01-BACKUP-BACKUP";
  };
  services.samba = {
    settings = {
      # "共享目录名称" = {
      #   "path" = "/path";                           # 共享目录
      #   "read only" = "no";                         # 是否只读
      #   "browseable" = "yes";                       # 指定该共享是否可以浏览
      #   "writable" = "yes";                         # 指定该共享路径是否可写
      #   "public" = "no";                            # 指定该共享是否允许 Guest 账户访问
      #   "create mask" = "0775";                     # 创建文件权限
      #   "directory mask" = "0775";                  # 创建目录权限
      #   # 设置用户、用户组权限（用户组使用 @ 符号表示），多个用户或用户组中间用逗号隔开
      #   # valid users 指定允许访问该共享资源的用户，如果不指定则所有用户都可访问
      #   "vaild users" = "user1, user2, user3";
      #   "vaild users" = "@group1, @group2, @group3";
      #   "vaild users" = "user1, user2, @group1, @group2";
      #   # 设置可对文件进行写操作的用户、用户组
      #   "write list" = "user1, user2, user3";
      #   "write list" = "@group1";
      #   # 强制用户或者组所有权，如果设置此项，则所有文件都将以此用户、用户组身份写入
      #   "force user" = "0x0CFF";
      #   "force group" = "users";
      #   # 以下参数用于配置回收站（空目录被删除不会放入回收站）
      #   "vfs object" = "recycle";                   # 载入 Samba 用于回收站功能的模块 recycle.so
      #   "recycle:repository" = ".Trash";            # 回收站的相对于共享资源目录的路径（删除文件位于共享资源目录下的 ".Trash" 目录）
      #   "recycle:repository" = ".Trash/%U";         # 回收站的相对于共享资源目录的路径（%U 变量表示当前浏览共享用户的用户名，所配置的目录其他用户必须有写权限，每个用户删除的文件都会存放在以他用户名命名的目录下）
      #   "recycle:versions" = "Yes";                 # 如果在回收站所在目录中存在同名文件，则以 "Copy #x of" 文件名的形式加以区分
      #   "recycle:keeptree" = "Yes";                 # 在将文件移入回收站时，要建立相对应的目录结构
      #   "recycle:maxsixe" = "0";                    # 回收站的最大使用空间，单位为字节，"0" 表示没有最大使用空间的限制
      #   "recycle:exclude_dir" = ".Trash";           # 排除文件夹（绝对路径，使用逗号隔开，支持通配符 * 和 ?）
      #   "recycle:exclude" = ".tmp|.mp3";            # 排除文件类型（使用逗号隔开）
      #   "recycle:noversions = *.doc";               # 如果在回收站所在目录中存在同名文件，覆盖原有文件的文件类型
      #   "recycle:touch_mtime" = "No";               # 删除文件时，是否应更新文件的上次修改日期
      # };
      # "DATASC01-BACKUP#01·归档盘" = {
      #   "path" = "/mnt/Archive#01/归档盘";           # 共享目录
      #   "read only" = "no";                         # 是否只读
      #   "browseable" = "yes";                       # 指定该共享是否可以浏览
      #   "writable" = "yes";                         # 指定该共享路径是否可写
      #   "public" = "no";                            # 指定该共享是否允许 Guest 账户访问
      #   "create mask" = "0775";                     # 创建文件权限
      #   "directory mask" = "0775";                  # 创建目录权限
      #   # 设置用户、用户组权限（用户组使用 @ 符号表示），多个用户或用户组中间用逗号隔开
      #   # valid users 指定允许访问该共享资源的用户，如果不指定则所有用户都可访问
      #   "vaild users" = "@PUBLIC";
      #   # 设置可对文件进行写操作的用户、用户组
      #   "write list" = "@PUBLIC";
      #   # 强制用户或者组所有权，如果设置此项，则所有文件都将以此用户、用户组身份写入
      #   # "force user" = "BUSINESS_R5";
      #   # "force group" = "PUBLIC";
      # };
      # "DATASC01-BACKUP#02·归档盘" = {
      #   "path" = "/mnt/Archive#02/归档盘";           # 共享目录
      #   "read only" = "no";                         # 是否只读
      #   "browseable" = "yes";                       # 指定该共享是否可以浏览
      #   "writable" = "yes";                         # 指定该共享路径是否可写
      #   "public" = "no";                            # 指定该共享是否允许 Guest 账户访问
      #   "create mask" = "0775";                     # 创建文件权限
      #   "directory mask" = "0775";                  # 创建目录权限
      #   # 设置用户、用户组权限（用户组使用 @ 符号表示），多个用户或用户组中间用逗号隔开
      #   # valid users 指定允许访问该共享资源的用户，如果不指定则所有用户都可访问
      #   "vaild users" = "@PUBLIC";
      #   # 设置可对文件进行写操作的用户、用户组
      #   "write list" = "@PUBLIC";
      #   # 强制用户或者组所有权，如果设置此项，则所有文件都将以此用户、用户组身份写入
      #   # "force user" = "BUSINESS_R5";
      #   # "force group" = "PUBLIC";
      # };
      # "DATASC01-BACKUP#03·归档盘" = {
      #   "path" = "/mnt/Archive#03/归档盘";           # 共享目录
      #   "read only" = "no";                         # 是否只读
      #   "browseable" = "yes";                       # 指定该共享是否可以浏览
      #   "writable" = "yes";                         # 指定该共享路径是否可写
      #   "public" = "no";                            # 指定该共享是否允许 Guest 账户访问
      #   "create mask" = "0775";                     # 创建文件权限
      #   "directory mask" = "0775";                  # 创建目录权限
      #   # 设置用户、用户组权限（用户组使用 @ 符号表示），多个用户或用户组中间用逗号隔开
      #   # valid users 指定允许访问该共享资源的用户，如果不指定则所有用户都可访问
      #   "vaild users" = "@PUBLIC";
      #   # 设置可对文件进行写操作的用户、用户组
      #   "write list" = "@PUBLIC";
      #   # 强制用户或者组所有权，如果设置此项，则所有文件都将以此用户、用户组身份写入
      #   # "force user" = "BUSINESS_R5";
      #   # "force group" = "PUBLIC";
      # };
      # "DATASC01-BACKUP#04·归档盘" = {
      #   "path" = "/mnt/Archive#04/归档盘";           # 共享目录
      #   "read only" = "no";                         # 是否只读
      #   "browseable" = "yes";                       # 指定该共享是否可以浏览
      #   "writable" = "yes";                         # 指定该共享路径是否可写
      #   "public" = "no";                            # 指定该共享是否允许 Guest 账户访问
      #   "create mask" = "0775";                     # 创建文件权限
      #   "directory mask" = "0775";                  # 创建目录权限
      #   # 设置用户、用户组权限（用户组使用 @ 符号表示），多个用户或用户组中间用逗号隔开
      #   # valid users 指定允许访问该共享资源的用户，如果不指定则所有用户都可访问
      #   "vaild users" = "@PUBLIC";
      #   # 设置可对文件进行写操作的用户、用户组
      #   "write list" = "@PUBLIC";
      #   # 强制用户或者组所有权，如果设置此项，则所有文件都将以此用户、用户组身份写入
      #   # "force user" = "BUSINESS_R5";
      #   # "force group" = "PUBLIC";
      # };
      # "DATASC01-BACKUP#05·归档盘" = {
      #   "path" = "/mnt/Archive#05/归档盘";           # 共享目录
      #   "read only" = "no";                         # 是否只读
      #   "browseable" = "yes";                       # 指定该共享是否可以浏览
      #   "writable" = "yes";                         # 指定该共享路径是否可写
      #   "public" = "no";                            # 指定该共享是否允许 Guest 账户访问
      #   "create mask" = "0775";                     # 创建文件权限
      #   "directory mask" = "0775";                  # 创建目录权限
      #   # 设置用户、用户组权限（用户组使用 @ 符号表示），多个用户或用户组中间用逗号隔开
      #   # valid users 指定允许访问该共享资源的用户，如果不指定则所有用户都可访问
      #   "vaild users" = "@PUBLIC";
      #   # 设置可对文件进行写操作的用户、用户组
      #   "write list" = "@PUBLIC";
      #   # 强制用户或者组所有权，如果设置此项，则所有文件都将以此用户、用户组身份写入
      #   # "force user" = "BUSINESS_R5";
      #   # "force group" = "PUBLIC";
      # };
      # "DATASC01-BACKUP#06·归档盘" = {
      #   "path" = "/mnt/Archive#06/归档盘";           # 共享目录
      #   "read only" = "no";                         # 是否只读
      #   "browseable" = "yes";                       # 指定该共享是否可以浏览
      #   "writable" = "yes";                         # 指定该共享路径是否可写
      #   "public" = "no";                            # 指定该共享是否允许 Guest 账户访问
      #   "create mask" = "0775";                     # 创建文件权限
      #   "directory mask" = "0775";                  # 创建目录权限
      #   # 设置用户、用户组权限（用户组使用 @ 符号表示），多个用户或用户组中间用逗号隔开
      #   # valid users 指定允许访问该共享资源的用户，如果不指定则所有用户都可访问
      #   "vaild users" = "@PUBLIC";
      #   # 设置可对文件进行写操作的用户、用户组
      #   "write list" = "@PUBLIC";
      #   # 强制用户或者组所有权，如果设置此项，则所有文件都将以此用户、用户组身份写入
      #   # "force user" = "BUSINESS_R5";
      #   # "force group" = "PUBLIC";
      # };
      # "DATASC01-BACKUP#07·归档盘" = {
      #   "path" = "/mnt/Archive#07/归档盘";           # 共享目录
      #   "read only" = "no";                         # 是否只读
      #   "browseable" = "yes";                       # 指定该共享是否可以浏览
      #   "writable" = "yes";                         # 指定该共享路径是否可写
      #   "public" = "no";                            # 指定该共享是否允许 Guest 账户访问
      #   "create mask" = "0775";                     # 创建文件权限
      #   "directory mask" = "0775";                  # 创建目录权限
      #   # 设置用户、用户组权限（用户组使用 @ 符号表示），多个用户或用户组中间用逗号隔开
      #   # valid users 指定允许访问该共享资源的用户，如果不指定则所有用户都可访问
      #   "vaild users" = "@PUBLIC";
      #   # 设置可对文件进行写操作的用户、用户组
      #   "write list" = "@PUBLIC";
      #   # 强制用户或者组所有权，如果设置此项，则所有文件都将以此用户、用户组身份写入
      #   # "force user" = "BUSINESS_R5";
      #   # "force group" = "PUBLIC";
      # };
      # "DATASC01-BACKUP#08·归档盘" = {
      #   "path" = "/mnt/Archive#08/归档盘";           # 共享目录
      #   "read only" = "no";                         # 是否只读
      #   "browseable" = "yes";                       # 指定该共享是否可以浏览
      #   "writable" = "yes";                         # 指定该共享路径是否可写
      #   "public" = "no";                            # 指定该共享是否允许 Guest 账户访问
      #   "create mask" = "0775";                     # 创建文件权限
      #   "directory mask" = "0775";                  # 创建目录权限
      #   # 设置用户、用户组权限（用户组使用 @ 符号表示），多个用户或用户组中间用逗号隔开
      #   # valid users 指定允许访问该共享资源的用户，如果不指定则所有用户都可访问
      #   "vaild users" = "@PUBLIC";
      #   # 设置可对文件进行写操作的用户、用户组
      #   "write list" = "@PUBLIC";
      #   # 强制用户或者组所有权，如果设置此项，则所有文件都将以此用户、用户组身份写入
      #   # "force user" = "BUSINESS_R5";
      #   # "force group" = "PUBLIC";
      # };
    };
  };
}
