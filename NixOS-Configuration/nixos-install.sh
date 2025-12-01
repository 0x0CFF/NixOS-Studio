#!/bin/sh
# Description : 构建完整 NixOS 系统
# Useage : sudo sh nixos-install.sh

######################################################### 批量添加 SMB 用户 #########################################################

# 定义要创建的用户数组（用户名:密码）
USERS=(
    # 行政部门
    "ADMINISTRATION_R0:K2NGW84T"     # 行政部门-实习
    "ADMINISTRATION_R1:CRKNF72C"     # 行政部门-初级
    "ADMINISTRATION_R2:ZEYM4DMN"     # 行政部门-中级
    "ADMINISTRATION_R3:PA9QF9Q3"     # 行政部门-高级
    "ADMINISTRATION_R4:Y7BWEU3N"     # 行政部门-主管
    "ADMINISTRATION_R5:Y87GKEHJ"     # 行政部门-总监
    # 动画部门
    "ANIMATION_R0:HG7G3R37"          # 动画部门-实习
    "ANIMATION_R1:MWN8JYM6"          # 动画部门-初级
    "ANIMATION_R2:DH3J5M4J"          # 动画部门-中级
    "ANIMATION_R3:H9HVFY6N"          # 动画部门-高级
    "ANIMATION_R4:CDF7VG4X"          # 动画部门-主管
    "ANIMATION_R5:AUS38NTL"          # 动画部门-总监
    # 董事会
    "BOARD_R0:EN35TSUX"              # 董事秘书-实习
    "BOARD_R1:TN4F8YLH"              # 董事秘书-正式
    "BOARD_R2:GBNE26R7"              # 董事成员
    "BOARD_R3:F7EY6KJM"              # 执行董事
    "BOARD_R4:M5LF7M65"              # 副董事长
    "BOARD_R5:A8HFKF8M"              # 董事长
    # 商务部门
    "BUSINESS_R0:WF457FQ7"           # 商务部门-实习
    "BUSINESS_R1:QPH3T2AS"           # 商务部门-初级
    "BUSINESS_R2:CYSMWAP3"           # 商务部门-中级
    "BUSINESS_R3:MJE3ZD86"           # 商务部门-高级
    "BUSINESS_R4:Q7CE3HGW"           # 商务部门-主管
    "BUSINESS_R5:SPCTYM37"           # 商务部门-总监
    # 设计部门
    "DESIGN_R0:K68N4GEH"             # 设计部门-实习
    "DESIGN_R1:GEK26RBW"             # 设计部门-初级
    "DESIGN_R2:CPSFB7PK"             # 设计部门-中级
    "DESIGN_R3:QDY7SBK3"             # 设计部门-高级
    "DESIGN_R4:RY82N8JX"             # 设计部门-主管
    "DESIGN_R5:PHRA45FF"             # 设计部门-总监
    # 开发部门
    "DEVELOPMENT_R0:PGNJTZ6V"        # 开发部门-实习
    "DEVELOPMENT_R1:GD4GEAVQ"        # 开发部门-初级
    "DEVELOPMENT_R2:T6TW7BFQ"        # 开发部门-中级
    "DEVELOPMENT_R3:NSN8G7R4"        # 开发部门-高级
    "DEVELOPMENT_R4:NRACA2MJ"        # 开发部门-主管
    "DEVELOPMENT_R5:MGCT6JK6"        # 开发部门-总监
    # 财务部门
    "FINANCE_R0:G35EXZYC"            # 财务部门-实习
    "FINANCE_R1:Q2HSA5ZX"            # 财务部门-初级
    "FINANCE_R2:FE5R29QY"            # 财务部门-中级
    "FINANCE_R3:D78RZQDX"            # 财务部门-高级
    "FINANCE_R4:DQ92FXRF"            # 财务部门-主管
    "FINANCE_R5:F28MF8LU"            # 财务部门-总监
    # 运维部门
    "OPERATION_R0:WM3E8FZ4"          # 运维部门-实习
    "OPERATION_R1:WF5ZPXW8"          # 运维部门-初级
    "OPERATION_R2:C56UA3NK"          # 运维部门-中级
    "OPERATION_R3:V4KQZ4CZ"          # 运维部门-高级
    "OPERATION_R4:WN8W6DZS"          # 运维部门-主管
    "OPERATION_R5:B6XCURH4"          # 运维部门-总监
    # 视频部门
    "VIDEO_R0:K3GTMT5E"              # 视频部门-实习
    "VIDEO_R1:F5SVQF9K"              # 视频部门-初级
    "VIDEO_R2:HG4KZ6NB"              # 视频部门-中级
    "VIDEO_R3:DU5NE8RJ"              # 视频部门-高级
    "VIDEO_R4:JMJU77CB"              # 视频部门-主管
    "VIDEO_R5:X73D32ZF"              # 视频部门-总监
)

# 函数 : 检查 SMB 用户是否存在
check_smb_user() {
    pdbedit -L | grep -q "^$1:"
}

# 函数 : 批量创建用户
batch_create_smb_users() {
    local success_count=0
    local skip_count=0
    local fail_count=0

    echo "开始批量创建 SMB 用户..."
    echo "================================"

    for user_info in "${USERS[@]}"; do
        # 分割用户名和密码
        IFS=':' read -r username password <<< "$user_info"

        echo "处理用户: $username"

        # 检查用户是否已存在
        if check_smb_user "$username"; then
            echo "用户 $username 已存在，跳过"
            skip_count=$((skip_count + 1))
            continue
        fi

        # 创建 SMB 用户
        echo -e "$password\n$password" | smbpasswd -a -s "$username"

        if [ $? -eq 0 ]; then
            echo "用户 $username 创建成功"
            success_count=$((success_count + 1))
        else
            echo "错误：无法创建 SMB 用户 $username"
            fail_count=$((fail_count + 1))
        fi

        echo "--------------------------------"
    done

    echo "================================"
    echo "批量创建完成！"
    echo "成功创建: $success_count"
    echo "跳过用户: $skip_count"
    echo "失败用户: $fail_count"
}

################################################ 创建 mnt 目录（NODENS00, NODENS00-BACKUP） ###############################################

# 定义要创建的挂载点
NODENS_MOUNTPOINTS=(
    "/mnt/Temp/:BOARD_R5:PUBLIC:775"
    "/mnt/Workspace/:BOARD_R5:PUBLIC:775"
    "/mnt/Document/:BOARD_R5:PUBLIC:775"
)

# 函数 : 批量创建文件夹
batch_create_nodens_mountpoint() {
    # 遍历数组创建文件夹
    for folder_info in "${NODENS_MOUNTPOINTS[@]}"; do

        # 分割用户名和密码
        IFS=':' read -r folder owner group permission<<< "$folder_info"

        # 检查文件夹是否已存在
        if [ -d "$folder" ]; then
            echo "文件夹已存在: $folder"
        else
            # 创建文件夹（-p 参数会自动创建父级目录）
            if mkdir -p "$folder"; then
                sudo chown -R $owner:$group $folder
                sudo chmod -R $permission $folder
                echo "成功创建文件夹: $folder"
            else
                echo "创建文件夹失败: $folder"
            fi
        fi
    done
}

# 定义要创建的文件夹
NODENS_FOLDERS=(
    "/mnt/Document/Obsidian/:BOARD_R5:PUBLIC:775"
    "/mnt/Document/Obsidian/公共文档:BOARD_R5:PUBLIC:775"
    "/mnt/Document/Obsidian/动画文档:ANIMATION_R5:ANIMATION:775"
    "/mnt/Document/Obsidian/设计文档:DESIGN_R5:DESIGN:775"
    "/mnt/Document/Obsidian/视频文档:VIDEO_R5:VIDEO:775"
    "/mnt/Document/Obsidian/财务文档:FINANCE_R5:FINANCE:770"
    "/mnt/Document/Obsidian/商务文档:BUSINESS_R5:BUSINESS:770"
    "/mnt/Document/Obsidian/运维文档:OPERATION_R5:OPERATION:775"
    "/mnt/Document/Obsidian/开发文档:DEVELOPMENT_R5:DEVELOPMENT:775"
    "/mnt/Document/Obsidian/行政文档:ADMINISTRATION_R5:ADMINISTRATION:770"
    "/mnt/Document/Keepass:BOARD_R5:PUBLIC:775"
    "/mnt/Document/Masscode:DEVELOPMENT_R5:DEVELOPMENT:775"
)

# 函数 : 批量创建文件夹
batch_create_nodens_folder() {
    # 遍历数组创建文件夹
    for folder_info in "${NODENS_FOLDERS[@]}"; do

        # 分割用户名和密码
        IFS=':' read -r folder owner group permission<<< "$folder_info"

        # 检查文件夹是否已存在
        if [ -d "$folder" ]; then
            echo "文件夹已存在: $folder"
        else
            # 创建文件夹（-p 参数会自动创建父级目录）
            if mkdir -p "$folder"; then
                sudo chown -R $owner:$group $folder
                sudo chmod -R $permission $folder
                echo "成功创建文件夹: $folder"
            else
                echo "创建文件夹失败: $folder"
            fi
        fi
    done
}

################################################ 创建 mnt 目录（DATASC00, DATASC00-BACKUP） ###############################################

# 定义要创建的挂载点
DATASC00_MOUNTPOINTS=(
    "/mnt/Material#PUBLIC/:BOARD_R5:PUBLIC:755"
    "/mnt/Material#FINANCE/:FINANCE_R5:FINANCE:750"
    "/mnt/Material#BUSINESS/:BUSINESS_R5:BUSINESS:750"
    "/mnt/Material#DESIGN/:DESIGN_R5:DESIGN:755"
    "/mnt/Material#VIDEO/:VIDEO_R5:VIDEO:755"
    "/mnt/Material#ANIMATION/:ANIMATION_R5:ANIMATION:755"
)

# 函数 : 批量创建文件夹
batch_create_datasc00_mountpoint() {
    # 遍历数组创建文件夹
    for folder_info in "${DATASC00_MOUNTPOINTS[@]}"; do

        # 分割用户名和密码
        IFS=':' read -r folder owner group permission<<< "$folder_info"

        # 检查文件夹是否已存在
        if [ -d "$folder" ]; then
            echo "文件夹已存在: $folder"
        else
            # 创建文件夹（-p 参数会自动创建父级目录）
            if mkdir -p "$folder"; then
                sudo chown -R $owner:$group $folder
                sudo chmod -R $permission $folder
                echo "成功创建文件夹: $folder"
            else
                echo "创建文件夹失败: $folder"
            fi
        fi
    done
}

################################################ 创建 mnt 目录（DATASC01, DATASC01-BACKUP） ###############################################

# 定义要创建的挂载点
DATASC01_MOUNTPOINTS=(
    "/mnt/Archive#01/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#02/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#03/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#04/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#05/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#06/:BOARD_R5:PUBLIC:775"
)

# 函数 : 批量创建文件夹
batch_create_datasc01_mountpoint() {
    # 遍历数组创建文件夹
    for folder_info in "${DATASC01_MOUNTPOINTS[@]}"; do

        # 分割用户名和密码
        IFS=':' read -r folder owner group permission<<< "$folder_info"

        # 检查文件夹是否已存在
        if [ -d "$folder" ]; then
            echo "文件夹已存在: $folder"
        else
            # 创建文件夹（-p 参数会自动创建父级目录）
            if mkdir -p "$folder"; then
                sudo chown -R $owner:$group $folder
                sudo chmod -R $permission $folder
                echo "成功创建文件夹: $folder"
            else
                echo "创建文件夹失败: $folder"
            fi
        fi
    done
}

############################################################## 主函数 #############################################################

# 显示菜单函数
show_menu() {
    echo "====== 请选择 Hostname ======"
    echo "1. NODENS00"
    echo "2. NODENS00-BACKUP"
    echo "3. DATASC00"
    echo "4. DATASC00-BACKUP"
    echo "5. DATASC01"
    echo "6. DATASC01-BACKUP"
    echo "7. DATAHC00"
    echo "8. DATAHC01"
    echo "============================"
}

# 显示二级菜单函数
show_submenu() {
    echo "====== 请选择操作 ======"
    echo "1. Switch Flake"
    echo "2. Create SMB User"
    echo "3. Init SMB Mountpoint"
    echo "4. Init SMB Folder"
    echo "============================"
}

# 处理用户选择
handle_choice() {
    case $1 in
        1)
            echo  # 空行
            echo "========= NODENS00 ========="
            case $2 in
                1)
                    # 复制硬件信息
                    cp -f /etc/nixos/hardware-configuration.nix /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake/Hosts/NODENS/NODENS00/Device/
                    # 构建 NixOS 系统
                    sudo nixos-rebuild switch --flake /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake#NODENS00 --show-trace --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
                    exit 0
                    ;;
                2)
                    echo  # 空行
                    # 构建 SMB 用户群
                    batch_create_smb_users
                    exit 0
                    ;;
                3)
                    echo  # 空行
                    # 构建 SMB 挂载点
                    batch_create_nodens_mountpoint
                    exit 0
                    ;;
                4)
                    echo  # 空行
                    # 构建 SMB 共享文件夹
                    batch_create_nodens_folder
                    exit 0
                    ;;
                *)
                    echo  # 空行
                    echo "错误选择，请重新输入！"
                    ;;
            esac
            ;;
        2)
            echo  # 空行
            echo "========= NODENS00-BACKUP ========="
            case $2 in
                1)
                    # 复制硬件信息
                    cp -f /etc/nixos/hardware-configuration.nix /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake/Hosts/NODENS/NODENS00-BACKUP/Device/
                    sudo nixos-rebuild switch --flake /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake#NODENS00-BACKUP --show-trace --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
                    exit 0
                    ;;
                2)
                    echo  # 空行
                    # 构建 SMB 用户群
                    batch_create_smb_users
                    exit 0
                    ;;
                3)
                    echo  # 空行
                    # 构建 SMB 挂载点
                    batch_create_nodens_mountpoint
                    exit 0
                    ;;
                4)
                    echo  # 空行
                    # 构建 SMB 共享文件夹
                    batch_create_nodens_folder
                    exit 0
                    ;;
                *)
                    echo  # 空行
                    echo "错误选择，请重新输入！"
                    ;;
            esac
            ;;
        3)
            echo  # 空行
            echo "========= DATASC00 ========="
            case $2 in
                1)
                    # 复制硬件信息
                    cp -f /etc/nixos/hardware-configuration.nix /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake/Hosts/DATASC/DATASC00/Device/
                    sudo nixos-rebuild switch --flake /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake#DATASC00 --show-trace --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
                    exit 0
                    ;;
                2)
                    echo  # 空行
                    # 构建 SMB 用户群
                    batch_create_smb_users
                    exit 0
                    ;;
                3)
                    echo  # 空行
                    # 构建 SMB 挂载点
                    batch_create_datasc00_mountpoint
                    exit 0
                    ;;
                4)
                    echo  # 空行
                    echo "无须构建！"
                    ;;
                *)
                    echo  # 空行
                    echo "错误选择，请重新输入！"
                    ;;
            esac
            ;;
        4)
            echo  # 空行
            echo "========= DATASC00-BACKUP ========="
            case $2 in
                1)
                    # 复制硬件信息
                    cp -f /etc/nixos/hardware-configuration.nix /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake/Hosts/DATASC/DATASC00-BACKUP/Device/
                    sudo nixos-rebuild switch --flake /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake#DATASC00-BACKUP --show-trace --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
                    exit 0
                    ;;
                2)
                    echo  # 空行
                    # 构建 SMB 用户群
                    batch_create_smb_users
                    exit 0
                    ;;
                3)
                    echo  # 空行
                    # 构建 SMB 挂载点
                    batch_create_datasc00_mountpoint
                    exit 0
                    ;;
                4)
                    echo  # 空行
                    echo "无须构建！"
                    ;;
                *)
                    echo  # 空行
                    echo "错误选择，请重新输入！"
                    ;;
            esac
            ;;
        5)
            echo  # 空行
            echo "========= DATASC01 ========="
            case $2 in
                1)
                    # 复制硬件信息
                    cp -f /etc/nixos/hardware-configuration.nix /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake/Hosts/DATASC/DATASC01/Device/
                    sudo nixos-rebuild switch --flake /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake#DATASC01 --show-trace --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
                    exit 0
                    ;;
                2)
                    echo  # 空行
                    # 构建 SMB 用户群
                    batch_create_smb_users
                    exit 0
                    ;;
                3)
                    echo  # 空行
                    # 构建 SMB 挂载点
                    batch_create_datasc01_mountpoint
                    exit 0
                    ;;
                4)
                    echo  # 空行
                    echo "无须构建！"
                    ;;
                *)
                    echo  # 空行
                    echo "错误选择，请重新输入！"
                    ;;
            esac
            ;;
        6)
            echo  # 空行
            echo "========= DATASC01-BACKUP ========="
            case $2 in
                1)
                    # 复制硬件信息
                    cp -f /etc/nixos/hardware-configuration.nix /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake/Hosts/DATASC/DATASC01-BACKUP/Device/
                    sudo nixos-rebuild switch --flake /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake#DATASC01-BACKUP --show-trace --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
                    exit 0
                    ;;
                2)
                    echo  # 空行
                    # 构建 SMB 用户群
                    batch_create_smb_users
                    exit 0
                    ;;
                3)
                    echo  # 空行
                    # 构建 SMB 挂载点
                    batch_create_datasc01_mountpoint
                    exit 0
                    ;;
                4)
                    echo  # 空行
                    echo "无须构建！"
                    ;;
                *)
                    echo  # 空行
                    echo "错误选择，请重新输入！"
                    ;;
            esac
            ;;
        7)
            echo  # 空行
            echo "========= DATAHC00 ========="
            case $2 in
                1)
                    # 复制硬件信息
                    cp -f /etc/nixos/hardware-configuration.nix /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake/Hosts/DATAHC/DATAHC00/Device/
                    sudo nixos-rebuild switch --flake /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake#DATAHC00 --show-trace --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
                    exit 0
                    ;;
                2)
                    echo  # 空行
                    echo "无须构建！"
                    ;;
                3)
                    echo  # 空行
                    echo "无须构建！"
                    ;;
                4)
                    echo  # 空行
                    echo "无须构建！"
                    ;;
            esac
            ;;
        8)
            echo  # 空行
            echo "========= DATAHC01 ========="
            case $2 in
                1)
                    # 复制硬件信息
                    cp -f /etc/nixos/hardware-configuration.nix /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake/Hosts/DATAHC/DATAHC01/Device/
                    sudo nixos-rebuild switch --flake /home/0x0CFF/Solution/Profiles/NixOS-Studio/NixOS-Flake#DATAHC01 --show-trace --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
                    exit 0
                    ;;
                2)
                    echo  # 空行
                    echo "无须构建！"
                    ;;
                3)
                    echo  # 空行
                    echo "无须构建！"
                    ;;
                4)
                    echo  # 空行
                    echo "无须构建！"
                    ;;
            esac
            ;;
        *)
            echo  # 空行
            echo "错误选择，请重新输入！"
            ;;
    esac
}

# 主循环
while true; do
    show_menu
    read -p "请输入选择 [1-8]: " choice1
    show_submenu
    read -p "请输入选择 [1-4]: " choice2
    handle_choice "$choice1" "$choice2"
    echo  # 空行
done
