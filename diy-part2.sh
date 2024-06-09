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

#删掉默认主题&&下载新主题
#lean-lede
#rm -rf package/lean/luci-theme-argon
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config.git  package/lean/luci-app-argon-config

#openwrt #CONFIG_PACKAGE_luci-theme-argon=y
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

#替换编译luci-app-xfrpc软件
#rm -rf /package/feeds/packages/xfrpc
#git clone https://github.com/liudf0716/xfrpc.git package/xfrpc
rm -rf package/feeds/luci/luci-app-xfrpc
git clone https://github.com/liudf0716/luci-app-xfrpc.git  package/feeds/luci/luci-app-xfrpc

#下载原版frp
#git clone https://github.com/kuoruan/openwrt-frp.git package/lean/frp

#添加autoreboot插件
#git clone https://github.com/f8q8/luci-app-autoreboot.git package/luci-app-autoreboot

