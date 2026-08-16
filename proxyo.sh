#!/usr/bin/env bash

cd /root || exit 1
####

## Function to print colored text
echocolor() {
    local color
    case "$1" in
        red)    color="\033[31m" ;;
        green)  color="\033[32m" ;;
        yellow) color="\033[33m" ;;
        cyan)   color="\033[36m" ;;
        *)      color="\033[0m" ;;
    esac

    echo -e "${color}$2\033[0m$3"
}

## main menu
while true; do
    echo "=============================="
    echocolor red "            Proxy"
    echo "=============================="
    echo
    echocolor red "11. " "Teddysun"
    echocolor red "12. " "Uninstall Shadowsocks"
    echocolor red "13. " "Shadowsocks Status"
    echocolor red "14. " "Shadowsocks Config Info"
    echo
    echo "------------------------------"
    echo
    echocolor red "21. " "v2ray-agent"
    echocolor red "22. " "vasma"
    echo
    echocolor red " 0. " "Exit"
    echo

    read -r -p "Please select: " choice
    echo

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
            echo "Invalid option."
            ;;
    esac
    echo

done