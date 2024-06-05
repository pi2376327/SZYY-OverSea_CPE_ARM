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

if [ ! -d /etc/uci-defaults ];then
        mkdir -p /etc/uci-defaults
fi

cat <<EOF > /etc/uci-defaults/99-custom
#!/bin/sh

#修改root密码
passwd root << EOI
szyywx.cn
szyywx.cn
EOI

#修改默认主题为argon
#uci -q batch << EOI
#set luci.themes.Argon=/luci-static/argon
#set luci.main.mediaurlbase=/luci-static/argon
#commit luci
#EOI

#修改名称,时区, 添加一个ntp服务地址,启用console登录密码
uci -q batch << EOI
set system.@system[0].hostname='YYWX-CPE'
set system.@system[0].zonename='Asia/Shanghai'
set system.@system[0].timezone='CST-8'
set system.ntp.use_dhcp='0'
set system.ntp.enabled='1'
set system.ntp.server='ntp.aliyun.com'
set system.@system[0].ttylogin='1'
commit system
EOI

#修改lan IP和DNSMASQ配置
uci -q batch << EOI
set network.lan.ipaddr='192.168.150.1'
commit network
set dhcp.@dnsmasq[0].cachesize='10000'
set dhcp.@dnsmasq[0].resolvfile='/etc/dnsmasq.resolv.conf'
set dhcp.@dnsmasq[0].filter_aaaa='1'
set dhcp.@dnsmasq[0].interface='lan'
commit dhcp
EOI

#更改wifi默认设置
#uci -q batch <<EOI
#set wireless.radio0.legacy_rates='1'
#set wireless.radio0.country='US'
#set wireless.radio0.channel='11'
#set wireless.default_radio0.ssid='YYWX-SDWAN'
#set wireless.default_radio0.encryption='psk2'
#set wireless.default_radio0.key='szyywx.cn'

#set wireless.radio1.country='US'
#set wireless.radio1.channel='149'
#set wireless.radio1.htmode='VHT40'
#set wireless.default_radio1.ssid='YYWX-SDWAN'
#set wireless.default_radio1.encryption='psk2'
#set wireless.default_radio1.key='szyywx.cn'
#commit wireless
#EOI

#sed -i '/option disabled/d' /etc/config/wireless
#sed -i '/set wireless.${name}.disabled/d' /lib/wifi/mac80211.sh

#增加vpn0接口
uci -q batch <<EOI
set network.vpn0=interface
set network.vpn0.ifname='tun0'
set network.vpn0.proto='none'
del network.wan6
commit network
EOI

#更改ssh\web默认端口
uci -q batch <<EOI
set dropbear.@dropbear[0].Port='24680'
delete dropbear.@dropbear[0].Interface
commit dropbear
set uhttpd.main.listen_http='0.0.0.0:24681'
set uhttpd.main.listen_https='0.0.0.0:24682'
commit uhttpd
EOI

#给脚本文件添加权限
chmod +x /etc/openvpn/openvpn-up.sh
chmod +x /etc/openvpn/openvpn-down.sh
chmod +x /root/script/update-chinaIPList.sh
chmod +x /root/script/openvpn-watchdog.sh
#touch ~/.vimrc
ln -s /usr/share/vim/vimrc /usr/share/vim/defaults.vim  #修复vim bug
rm -rf /etc/resolv.conf  #删除默认wan口dns地址
echo 'nameserver 127.0.0.1' > /etc/resolv.conf #增加dns指向本机dnsmasq


#增加crontab任务
echo '1 2 * * sun sh /root/script/update-chinaIPList.sh' >> /etc/crontabs/root
echo '*/5 * * * * sh /root/script/openvpn-watchdog.sh' >> /etc/crontabs/root
echo '0 5 * * sun reboot &' >> /etc/crontabs/root   #每周日凌晨5点重启

exit 0
EOF
