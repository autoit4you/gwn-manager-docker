#!/bin/bash

if [ ! -f /gwn/data/.GWN_MANAGER_DOCKER ] || [ "1.1.35.10" != "$(cat /gwn/data/.GWN_MANAGER_DOCKER)"]; then
    dpkg -i /GWN_Manager-1.1.35.10-Ubuntu/packages/*.deb
    /gwn/scripts/install_gwn.sh /GWN_Manager-1.1.35.10-Ubuntu/packages/GWN_Manager_Upgrade_1.1.35.10.tar.gz
    echo "1.1.35.10" > /gwn/data/.GWN_MANAGER_DOCKER
fi

/gwn/gwn start
tail -f /gwn/logs/**/*.log /gwn/logs/**/**/*.log /gwn/logs/**/**/*.out
