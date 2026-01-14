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
    # 特效部门
    "EFFECTS_R0:QGZM6FQA"            # 特效部门-实习
    "EFFECTS_R1:NRB6RHGF"            # 特效部门-初级
    "EFFECTS_R2:RZF3R4NS"            # 特效部门-中级
    "EFFECTS_R3:G4VHBJ4Z"            # 特效部门-高级
    "EFFECTS_R4:E5QHSHUD"            # 特效部门-主管
    "EFFECTS_R5:HSN4RFWQ"            # 特效部门-总监
    # 财务部门
    "FINANCE_R0:G35EXZYC"            # 财务部门-实习
    "FINANCE_R1:Q2HSA5ZX"            # 财务部门-初级
    "FINANCE_R2:FE5R29QY"            # 财务部门-中级
    "FINANCE_R3:D78RZQDX"            # 财务部门-高级
    "FINANCE_R4:DQ92FXRF"            # 财务部门-主管
    "FINANCE_R5:F28MF8LU"            # 财务部门-总监
    # 建模部门
    "MODELING_R0:N76RBDGS"           # 建模部门-实习
    "MODELING_R1:KT4V2NPV"           # 建模部门-初级
    "MODELING_R2:HWJS87K7"           # 建模部门-中级
    "MODELING_R3:WJC4WSEH"           # 建模部门-高级
    "MODELING_R4:VNH5DS48"           # 建模部门-主管
    "MODELING_R5:KQ64FZ8R"           # 建模部门-总监
    # 运维部门
    "OPERATION_R0:WM3E8FZ4"          # 运维部门-实习
    "OPERATION_R1:WF5ZPXW8"          # 运维部门-初级
    "OPERATION_R2:C56UA3NK"          # 运维部门-中级
    "OPERATION_R3:V4KQZ4CZ"          # 运维部门-高级
    "OPERATION_R4:WN8W6DZS"          # 运维部门-主管
    "OPERATION_R5:B6XCURH4"          # 运维部门-总监
    # 摄影部门
    "PHOTOGRAPHY_R0:RD528VP5"        # 摄影部门-实习
    "PHOTOGRAPHY_R1:VNU2YR76"        # 摄影部门-初级
    "PHOTOGRAPHY_R2:USKSN4AB"        # 摄影部门-中级
    "PHOTOGRAPHY_R3:H4N4NZB3"        # 摄影部门-高级
    "PHOTOGRAPHY_R4:NKXJZ34B"        # 摄影部门-主管
    "PHOTOGRAPHY_R5:RGJ8A8UM"        # 摄影部门-总监
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

        # 检查用户是否存在
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

######################################################### 构建 SMB 挂载点 #########################################################

# 定义要创建的挂载点（DATABC00, DATABC00-BACKUP）
DATABC_MOUNTPOINTS=(
    "/mnt/Temp/:root:root:775"
    "/mnt/Temp/.Trash-0/:root:root:775"
    "/mnt/Workspace/:root:root:775"
    "/mnt/Workspace/.Trash-0/:root:root:775"
    "/mnt/Document/:root:root:775"
    "/mnt/Document/.Trash-0/:root:root:775"
)

# 定义要创建的挂载点（DATASC00, DATASC00-BACKUP）
DATASC00_MOUNTPOINTS=(
    "/mnt/Inspiration#PUBLIC/:root:root:775"
    "/mnt/Inspiration#PUBLIC/.Trash-0/:root:root:775"
    "/mnt/Material#PUBLIC/:root:root:775"
    "/mnt/Material#PUBLIC/.Trash-0/:root:root:775"
    "/mnt/Material#DESIGN/:root:root:775"
    "/mnt/Material#DESIGN/.Trash-0/:root:root:775"
    "/mnt/Material#VIDEO/:root:root:775"
    "/mnt/Material#VIDEO/.Trash-0/:root:root:775"
    "/mnt/Material#MODELING/:root:root:775"
    "/mnt/Material#MODELING/.Trash-0/:root:root:775"
    "/mnt/Material#EFFECTS/:root:root:775"
    "/mnt/Material#EFFECTS/.Trash-0/:root:root:775"
    "/mnt/Material#ANIMATION/:root:root:775"
    "/mnt/Material#ANIMATION/.Trash-0/:root:root:775"
    "/mnt/Material#BUSINESS/:root:root:775"
    "/mnt/Material#BUSINESS/.Trash-0/:root:root:775"
)

# 定义要创建的挂载点（DATASC01, DATASC01-BACKUP）
DATASC01_MOUNTPOINTS=(
    "/mnt/Archive#01/:root:root:775"
    "/mnt/Archive#01/.Trash-0/:root:root:775"
    "/mnt/Archive#02/:root:root:775"
    "/mnt/Archive#02/.Trash-0/:root:root:775"
    "/mnt/Archive#03/:root:root:775"
    "/mnt/Archive#03/.Trash-0/:root:root:775"
    "/mnt/Archive#04/:root:root:775"
    "/mnt/Archive#04/.Trash-0/:root:root:775"
    "/mnt/Archive#05/:root:root:775"
    "/mnt/Archive#05/.Trash-0/:root:root:775"
    "/mnt/Archive#06/:root:root:775"
    "/mnt/Archive#06/.Trash-0/:root:root:775"
    "/mnt/Archive#07/:root:root:775"
    "/mnt/Archive#07/.Trash-0/:root:root:775"
    "/mnt/Archive#08/:root:root:775"
    "/mnt/Archive#08/.Trash-0/:root:root:775"
)

#############################################@########## 构建 SMB 共享文件夹 #######################################################

# 定义要创建的文件夹
DATABC_FOLDERS=(
    "/mnt/Temp/临时盘/:BOARD_R5:PUBLIC:775"
    "/mnt/Temp/临时盘/.Trash/:BOARD_R5:PUBLIC:775"
    "/mnt/Workspace/协作盘/:BOARD_R5:PUBLIC:775"
    "/mnt/Workspace/协作盘/.Trash/:BOARD_R5:PUBLIC:775"
    "/mnt/Document/文档盘/:BOARD_R5:PUBLIC:775"
    "/mnt/Document/文档盘/.Trash/:BOARD_R5:PUBLIC:775"
    "/mnt/Document/文档盘/Masscode:DEVELOPMENT_R5:DEVELOPMENT:755"
    "/mnt/Document/文档盘/Obsidian/:BOARD_R5:PUBLIC:775"
    "/mnt/Document/文档盘/Obsidian/行政文档:ADMINISTRATION_R5:ADMINISTRATION:750"
    "/mnt/Document/文档盘/Obsidian/动画文档:ANIMATION_R5:ANIMATION:755"
    "/mnt/Document/文档盘/Obsidian/公共文档:BOARD_R5:PUBLIC:755"
    "/mnt/Document/文档盘/Obsidian/商务文档:BUSINESS_R5:BUSINESS:750"
    "/mnt/Document/文档盘/Obsidian/设计文档:DESIGN_R5:DESIGN:755"
    "/mnt/Document/文档盘/Obsidian/开发文档:DEVELOPMENT_R5:DEVELOPMENT:755"
    "/mnt/Document/文档盘/Obsidian/特效文档:EFFECTS_R5:EFFECTS:755"
    "/mnt/Document/文档盘/Obsidian/财务文档:FINANCE_R5:FINANCE:750"
    "/mnt/Document/文档盘/Obsidian/建模文档:MODELING_R5:MODELING:755"
    "/mnt/Document/文档盘/Obsidian/运维文档:OPERATION_R5:OPERATION:755"
    "/mnt/Document/文档盘/Obsidian/摄影文档:PHOTOGRAPHY_R5:PHOTOGRAPHY:755"
    "/mnt/Document/文档盘/Obsidian/视频文档:VIDEO_R5:VIDEO:755"
)

DATASC00_FOLDERS=(
    "/mnt/Inspiration#PUBLIC/公共灵感库.library/:BOARD_R5:PUBLIC:755"
    "/mnt/Material#ANIMATION/动画素材库.library/:ANIMATION_R5:ANIMATION:755"
    "/mnt/Material#BUSINESS/商务素材库.library/:BUSINESS_R5:BUSINESS:750"
    "/mnt/Material#DESIGN/设计素材库.library/:DESIGN_R5:DESIGN:755"
    "/mnt/Material#EFFECTS/特效素材库.library/:EFFECTS_R5:EFFECTS:755"
    "/mnt/Material#MODELING/建模素材库.library/:MODELING_R5:MODELING:755"
    "/mnt/Material#PUBLIC/公共素材库.library/:BOARD_R5:PUBLIC:755"
    "/mnt/Material#VIDEO/视频素材库.library/:VIDEO_R5:VIDEO:755"
)

DATASC01_FOLDERS=(
    "/mnt/Archive#01/归档盘/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#01/归档盘/.Trash/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#02/归档盘/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#02/归档盘/.Trash/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#03/归档盘/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#03/归档盘/.Trash/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#04/归档盘/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#04/归档盘/.Trash/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#05/归档盘/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#05/归档盘/.Trash/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#06/归档盘/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#06/归档盘/.Trash/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#07/归档盘/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#07/归档盘/.Trash/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#08/归档盘/:BOARD_R5:PUBLIC:775"
    "/mnt/Archive#08/归档盘/.Trash/:BOARD_R5:PUBLIC:775"
)

# 函数 : 批量创建挂载点
batch_create_mountpoint() {
    # 引用数组
    local -n arr_ref=$1
    
    # 遍历数组
    for folder_info in "${arr_ref[@]}"; do
        # 分割用户名和密码
        IFS=':' read -r folder owner group permission<<< "$folder_info"

        # 检查挂载点是否存在
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

# 函数 : 批量创建 SMB 共享文件夹
batch_create_folder() {
    # 引用数组
    local -n arr_ref=$1
    
    # 遍历数组
    for folder_info in "${arr_ref[@]}"; do
        # 分割用户名和密码
        IFS=':' read -r folder owner group permission<<< "$folder_info"

        # 获取父级目录（挂载点）
        mountpoint=$(dirname "$folder")

        # 检查 SMB 共享文件夹是否存在
        if [ -d "$folder" ]; then
            echo
            echo "文件夹已存在: $folder"
        else
            echo
            echo "文件夹不存在: $folder"
            # 检查硬盘是否挂载（挂载硬盘的目录下会有 lost+found 文件夹）
            if [ -d "${mountpoint}/lost+found" ]; then
                echo "硬盘已挂载，正在创建 SMB 共享文件夹..."
                # 创建文件夹（-p 参数会自动创建父级目录）
                if mkdir -p "$folder"; then
                    sudo chown -R $owner:$group $folder
                    sudo chmod -R $permission $folder
                    echo "成功创建文件夹: $folder"
                else
                    echo "创建文件夹失败: $folder"
                fi
            else
                echo "硬盘未挂载，无法过创建 SMB 共享文件夹..."
            fi
        fi
    done
}

############################################################## 主函数 #############################################################

# 显示菜单函数
show_menu() {
    echo "--------------- 请选择操作 ---------------"
    echo "1. Switch Flake"
    echo "2. Create SMB User"
    echo "3. Init SMB Mountpoint"
    echo "4. Init SMB Folder"
    echo "-----------------------------------------"
}

# 处理用户选择
handle_choice() {
    echo  # 空行
    echo "主机名: $HOSTNAME"
    echo "-----------------------------------------"
    case $1 in
        1)  # NixOS Flake 
            echo  # 空行
            # 复制硬件信息
            cp -f /etc/nixos/hardware-configuration.nix /home/0x0CFF/Solution/Blueprints/NixOS/NixOS-Studio/NixOS-Flake/Hosts/${HOSTNAME%%0*}/$HOSTNAME/Device/
            # 构建 NixOS 系统
            sudo nixos-rebuild switch --flake /home/0x0CFF/Solution/Blueprints/NixOS/NixOS-Studio/NixOS-Flake#$HOSTNAME --show-trace --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
            exit 1
            ;;
        2)  # 构建 SMB 用户群
            case $HOSTNAME in
                "DATABC00"|"DATABC00-BACKUP"|"DATASC00"|"DATASC00-BACKUP"|"DATASC01"|"DATASC01-BACKUP"|"DATAHC00"|"DATAHC01")
                    echo  # 空行
                    batch_create_smb_users
                    exit 1
                    ;;
                *)
                    echo "$HOSTNAME 无须构建 SMB 用户群！"
                    exit 1
                    ;;
            esac
            exit 1
            ;;
        3)  # 构建 SMB 挂载点
            case $HOSTNAME in
                "DATABC00"|"DATABC00-BACKUP")
                    echo  # 空行
                    batch_create_mountpoint DATABC_MOUNTPOINTS
                    exit 1
                    ;;
                "DATASC00"|"DATASC00-BACKUP")
                    echo  # 空行
                    batch_create_mountpoint DATASC00_MOUNTPOINTS
                    exit 1
                    ;;
                "DATASC01"|"DATASC01-BACKUP")
                    echo  # 空行
                    batch_create_mountpoint DATASC01_MOUNTPOINTS
                    exit 1
                    ;;
                *)
                    echo "$HOSTNAME 无须构建 SMB 挂载点！"
                    exit 1
                    ;;
            esac
            exit 1
            ;;
        4)  # 构建 SMB 共享文件夹
            case $HOSTNAME in
                "DATABC00"|"DATABC00-BACKUP")
                    echo  # 空行
                    batch_create_folder DATABC_FOLDERS
                    exit 1
                    ;;
                "DATASC00"|"DATASC00-BACKUP")
                    echo  # 空行
                    batch_create_folder DATASC00_FOLDERS
                    exit 1
                    ;;
                "DATASC01"|"DATASC01-BACKUP")
                    echo  # 空行
                    batch_create_folder DATASC01_FOLDERS
                    exit 1
                    ;;
                *)
                    echo "$HOSTNAME 无须构建 SMB 共享文件夹！"
                    exit 1
                    ;;
            esac
            exit 1
            ;;
    esac
    exit 1
}

# 主循环
while true; do
    show_menu
    read -p "请输入选择 [1-4]: " choice1
    handle_choice "$choice1"
    echo  # 空行
done
