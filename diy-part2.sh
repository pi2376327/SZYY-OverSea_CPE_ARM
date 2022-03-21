#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.150.1/g' package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/jywx/g' package/base-files/files/bin/config_generate
cat >package/base-files/files/etc/banner<<EOF
  ____      _     ___   ____        ____  __
 | __ )    | |   | \ \ / /\ \      / /\ \/ /
 |  _ \ _  | |_  | |\ V /  \ \ /\ / /  \  / 
 | |_) | |_| | |_| | | |    \ V  V /   /  \ 
 |____/ \___/ \___/  |_|     \_/\_/   /_/\_\
                                            
---------------------------------------------------
     Access For Last-Miles With Intetnet
  
           since 2015,www.edpn.com.cn
---------------------------------------------------
EOF
#sed -i 's/root::0:0:99999:7:::/root:$1$kG.psLXF$eWnaXS9LQpId57E5ipfJO\/:18928:0:99999:7:::/g' package/base-files/files/etc/shadow
