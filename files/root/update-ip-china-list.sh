#!/bin/sh

#创建临时目录并下载ip地址源文件
mkdir -p /tmp/china-ip/
wget -P /tmp/china-ip/ https://raw.githubusercontent.com/metowolf/iplist/master/data/special/china.txt

#删除空行
grep -vE '^#|^&}' /tmp/china-ip/china.txt  > /tmp/china-ip/ip.txt

#转换为ipset格式，并移动至目标目录
sed -i 's/^/add chnroute /g' /tmp/china-ip/ip.txt
mv -f /tmp/china-ip/ip.txt /etc/openvpn/chnroute-ipset

#添加私有ip网段
echo "add chnroute 10.0.0.0/8" >> /etc/openvpn/chnroute-ipset
echo "add chnroute 172.16.0.0/12" >> /etc/openvpn/chnroute-ipset
echo "add chnroute 192.168.0.0/16" >> /etc/openvpn/chnroute-ipset

#ipset清空原数据并加载新配置
ipset flush chnroute
ipset restore -f /etc/openvpn/chnroute-ipset

#删除临时文件
rm -rf /tmp/china-ip

echo '--------------------------------------'
echo 'update ipv4 date from apnic completely'
echo -e '--------------------------------------\n\n'
