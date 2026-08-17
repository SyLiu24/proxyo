#!/usr/bin/env bash

cd /root || exit 1
####

## Function to print colored text
echocolor() {
    local color
    case "$1" in
        red)    color="\e[31m" ;;
        green)  color="\e[32m" ;;
        yellow) color="\e[33m" ;;
        yellowbg) color="\e[30;43m" ;;
        cyan)   color="\e[36m" ;;
        *)      color="\e[0m" ;;
    esac

    echo -e "${color}$2\e[0m$3"
}

## main menu
while true; do
    echo
    echocolor yellowbg "            Proxyo            "
    echo
    echocolor yellow "11. Teddysun"
    echocolor yellow "12. Uninstall Shadowsocks"
    echocolor yellow "13. Shadowsocks Status"
    echocolor yellow "14. Shadowsocks Config Info"
    echo
    echocolor yellow "------------------------------"
    echo
    echocolor yellow "21. v2ray-agent"
    echocolor yellow "22. vasma"
    echo
    echocolor yellow " 0. Exit"
    echo

    read -r -p $'\e[32mPlease select: \e[33m' choice
    echocolor 0

    case "$choice" in
        11)
            wget --no-check-certificate -O shadowsocks-all.sh \
                https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
            chmod +x shadowsocks-all.sh
            ./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
            ;;

        12)
            if  [[ -f /root/shadowsocks-all.sh ]]; then
                /root/shadowsocks-all.sh uninstall
            else
                echocolor red "shadowsocks-all.sh not found."
            fi
            ;;

        13)
            systemctl --no-pager status shadowsocks-libev-server
            ;;
        
        14)
            sed -n '/Congratulations,/,$p' /root/shadowsocks-all.log
            ;;

        21)
            wget -P /root -N --no-check-certificate \
                "https://raw.githubusercontent.com/mack-a/v2ray-agent/master/install.sh" \
                && chmod 700 /root/install.sh \
                && /root/install.sh
            ;;

        22)
            vasma
            ;;

        0)
            exit 0
            ;;

        *)
            echocolor red "Invalid option."
            ;;
    esac

done