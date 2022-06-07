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

#修改默认主机名
sed -i 's/OpenWrt/JYWX-CPE/g' package/base-files/files/bin/config_generate

#修改欢迎banner
cat >package/base-files/files/etc/banner<<EOF
  ____      _     ___   ____        ____  __
 | __ )    | |   | \ \ / /\ \      / /\ \/ /
 |  _ \ _  | |_  | |\ V /  \ \ /\ / /  \  / 
 | |_) | |_| | |_| | | |    \ V  V /   /  \ 
 |____/ \___/ \___/  |_|     \_/\_/   /_/\_\ 
                                            
--------------------------------------------------------
     Access For Last-Miles With Intetnet
  
           since 2015,www.edpn.com.cn
--------------------------------------------------------
EOF

#修改默认密码
sed -i '/root::0/d' package/lean/default-settings/files/zzz-default-settings

#替换版本和名字
sed -i 's/R22.3.13/R2022.6.7/g' package/lean/default-settings/files/zzz-default-settings
sed -i 's/OpenWrt/JYWX-CPE/g' package/lean/default-settings/files/zzz-default-settings
sed -i '1c\root:$1$KFkimD6C$KSpEWi1IcwqWYrESv2fQy/:19074:0:99999:7:::' package/base-files/files/etc/shadow

#修改编译者信息
sed -i '/CPU usage/a\                <tr><td width="33%"><%:Compiler author%></td><td>peter</td></tr>'  package/lean/autocore/files/arm/index.htm
sed -i '/CPU usage/a\                <tr><td width="33%"><%:Compiler author%></td><td>peter</td></tr>'  package/lean/autocore/files/x86/index.htm
cat >>feeds/luci/modules/luci-base/po/zh-cn/base.po<<EOF
msgid "Compiler author"
msgstr "编译者"
EOF

#更改默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile
