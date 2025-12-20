#!/bin/bash
# aes.sh - AES 加解密

# 加密函数
aes128_enc() {
    local text="$1"
    local pass="$2"
    
    if [ -z "$text" ] || [ -z "$pass" ]; then
        echo "用法: aes128_enc '文本' 密码"
        return 1
    fi
    
    # 加密并格式化输出
    echo -n "$text" | openssl enc -aes-128-cbc \
        -salt -pbkdf2 -iter 10000 \
        -pass pass:"$pass" \
        -base64 | tr -d '\n=' | head -c128
}

# 解密函数
aes128_dec() {
    local cipher="$1"
    local pass="$2"
    
    if [ -z "$cipher" ] || [ -z "$pass" ]; then
        echo "用法: aes128_dec '密文' 密码"
        return 1
    fi
    
    # 补全base64并解密
    local len=${#cipher}
    local padding=$((4 - len % 4))
    [ $padding -ne 4 ] && cipher="${cipher}$(printf '=%.0s' $(seq 1 $padding))"
    
    echo "$cipher" | openssl enc -aes-128-cbc -d \
        -salt -pbkdf2 -iter 10000 \
        -pass pass:"$pass" \
        -base64 2>/dev/null
}

# 命令行直接使用
case "$1" in
    enc|e)
        aes128_enc "$2" "$3"
        ;;
    dec|d)
        aes128_dec "$2" "$3"
        ;;
    *)
        echo "AES加解密工具（128字符输出）"
        echo "=============================="
        echo "加密: $0 enc '文本' 密码"
        echo "解密: $0 dec '密文' 密码"
        echo ""
        echo "示例:"
        echo "  $0 enc 'Hello World' mypass123"
        echo "  $0 dec 'U2FsdGVkX18...' mypass123"
        ;;
esac