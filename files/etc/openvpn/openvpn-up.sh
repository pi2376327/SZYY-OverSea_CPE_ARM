#!/bin/sh
src=$(ip addr show tun0 | grep 'inet ' | sed 's/^.*inet //g' | sed 's/\/16.*$//g')
iptables -t mangle -I PREROUTING -m set ! --match-set chnroute dst -j MARK --set-mark 1
iptables -t mangle -I OUTPUT -m set ! --match-set chnroute dst -j MARK --set-mark 1
ip route add default via 172.16.0.1 dev tun0 src $src table 100 
ip rule add from all fwmark 1 table 100
