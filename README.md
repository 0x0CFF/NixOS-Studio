# 构建指南

## 前置条件

1. 硬盘完成分区
2. 主分区挂载到根目录
3. 设备能够连接互联网

## 构建基础系统

从远程仓库拉取 `configuration.nix` 配置文件

```shell
# 生成配置文件
sudo nixos-generate-config --root /mnt

# 拉取远程仓库到本地
git clone https://github.com/0x0CFF/NixOS-Studio.git

# 复制配置文件
cp -f ./NixOS-Studio/NixOS-Configuration/configuration.nix /mnt/etc/nixos/

# 修改：系统引导、hostName
vim /mnt/etc/nixos/configuration.nix
```

`configuration.nix` 配置文件修改完后，执行系统构建命令

```shell
# 使用官方源进行构建
nixos-install --root /mnt

# 使用镜像源进行构建（清华大学）
nixos-install --root /mnt --option substituters "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"

# 使用镜像源进行构建（中国科学技术大学）
nixos-install --root /mnt --option substituters "https://mirrors.ustc.edu.cn/nix-channels/store"

# 使用镜像源进行构建（上海交通大学）
nixos-install --root /mnt --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
```

系统构建完成后，根据终端提示设置 `root` 用户密码

执行 `sudo reboot` 重启设备

登录 `root` 用户执行 `passwd 0x0CFF` 设置用户密码

## 构建完整系统

登录 `0x0CFF` 账户

```shell
# 拉取远程配置文件
# git clone https://github.com/0x0CFF/NixOS-Studio.git ~/Solution/Blueprints/NixOS/NixOS-Studio
GIT

# 替换硬件信息
HC

# 将系统 FLAKE 化（执行后，NixOS 切换到 Flake 模式，可执行 Flake 对应操作）
# sudo sh ~/Solution/Blueprints/NixOS/NixOS-Studio/Script/nixos-install.sh
FLAKE

# 重启电脑
sudo reboot

# 构建 /mnt 挂载点、SMB 用户群
# sudo sh ~/Solution/Blueprints/NixOS/NixOS-Studio/Script/nixos-install.sh
FLAKE

# 使用 mount 命令挂载硬盘到 /mnt 目录下
# 查看硬盘挂载情况
sudo lsblk -f
# NAVI [nixos]: 生成 `hardware-configuration.nix` 硬件信息
# HC: 替换硬件信息到 NixOS-Flake 相应文件夹下

# 构建 SMB 共享文件夹
# sudo sh ~/Solution/Blueprints/NixOS/NixOS-Studio/Script/nixos-install.sh
FLAKE

# 修改对应 Services/samba.nix 文件
# 修改 flake.nix 文件，开启 samba 专项
# NAVI [studio]: 构建系统
```
