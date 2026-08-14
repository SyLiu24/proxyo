#!/usr/bin/env bash

cd /root


menu() {
    echo "=============================="
    echo "            Proxy"
    echo "=============================="
    echo
    echo "11. Teddysun"
    echo "12. Uninstall Shadowsocks"
    echo "13. Shadowsocks Status"
    echo "14. Shadowsocks Config Info"
    echo
    echo "------------------------------"
    echo
    echo "21. v2ray-agent"
    echo "22. vasma"
    echo
    echo " 0. Exit"
    echo

    read -r -p "Please select: " choice

    case "$choice" in
        11)
            wget --no-check-certificate -O shadowsocks-all.sh \
                https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
            chmod +x shadowsocks-all.sh
            ./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
            menu
            ;;

        12)
            if  [[ -f /root/shadowsocks-all.sh ]]; then
                /root/shadowsocks-all.sh uninstall
            else
                echo "shadowsocks-all.sh not found."
            fi
            menu
            ;;

        13)
            systemctl status shadowsocks-libev-server
            menu
            ;;
        
        14)
            sed -n '/Congratulations,/,$p' /root/shadowsocks-all.log
            menu
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
            menu
            ;;
    esac
}

menu