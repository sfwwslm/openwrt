#!/bin/bash

CFG_FILE=package/base-files/files/bin/config_generate

# 检查是否提供了第二个参数
if [[ -z "$2" ]]; then
    read -rp "未提供主机名，输入 'y' 以使用默认值 'Main'，输入其他任意字符退出: " confirm
    if [[ "$confirm" != "y" ]]; then
        echo "脚本已终止。"
        exit 1
    fi
    HOSTNAME="Main"
else
    HOSTNAME="$2"
fi

# 修改配置文件中的主机名
sed -i "s/hostname='.*'/hostname='$HOSTNAME'/g" "$CFG_FILE"
echo "主机名已设置为: $HOSTNAME. 5秒后开始编译！"

mkdir -p files/lib/firmware

cp ci/ax211/* files/lib/firmware/

sleep 5

rm -rf bin/

if ! PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin make V=s -j"$1"
then
    echo "编译失败，请检查错误信息。"
fi

sed -i "s/hostname='.*'/hostname='OpenWrt'/g" "$CFG_FILE"
echo "已恢复配置文件中的主机名"