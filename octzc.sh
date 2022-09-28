#!/bin/bash

OS_NAME=$( cat /etc/os-release | grep ^NAME | cut -d'=' -f2 | sed 's/"//gI' )

case "$OS_NAME" in
    "CentOS Linux")
        sudo yum update -y
        sudo yum install ntpdate ntp -y

        sudo timedatectl set-timezone "Asia/Shanghai"
        sudo ntpdate -u ntp.aliyun.com time.windows.com time.apple.com time.google.com time.cloudflare.com
        sudo hwclock --systohc # 写入硬件

        sudo systemctl enable ntpd
        sudo systemctl start ntpd
        ;;
    "Ubuntu" | "Linux Mint")
        sudo apt update -y
        sudo apt install ntpdate ntp -y

        sudo timedatectl set-timezone "Asia/Shanghai"
        sudo ntpdate -u ntp.aliyun.com time.windows.com time.apple.com time.google.com time.cloudflare.com
        sudo hwclock --systohc # 写入硬件

        sudo systemctl enable ntp
        sudo systemctl start ntp
        ;;
esac
