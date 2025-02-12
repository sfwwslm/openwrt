#!/bin/bash

set -e 

./scripts/feeds update -a && ./scripts/feeds install -a

ATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin make defconfig

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin make download -j8 V=s

# scp "\\wsl.localhost\Ubuntu-22.04\home\gwj\code\openwrt\bin\targets\x86\64\openwrt-x86-64-generic-squashfs-combined-efi.img.gz" root@10.0.0.11:~/
