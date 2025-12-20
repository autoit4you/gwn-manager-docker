#!/bin/bash

if [ ! -f /gwn/data/.GWN_MANAGER_DOCKER ] || [ "$GWN_MANAGER_VERSION" != "$(cat /gwn/data/.GWN_MANAGER_DOCKER)" ]; then
    dpkg -i /GWN_Manager/packages/*.deb
    /gwn/scripts/install_gwn.sh "/GWN_Manager/packages/GWN_Manager_Upgrade_$GWN_MANAGER_VERSION.tar.gz" notstart
    echo "$GWN_MANAGER_VERSION" > /gwn/data/.GWN_MANAGER_DOCKER
fi

chown gwn:gwn /gwn/data /gwn/logs /gwn_backup

/gwn/gwn start
tail -F /gwn/logs/* 2>/dev/null
