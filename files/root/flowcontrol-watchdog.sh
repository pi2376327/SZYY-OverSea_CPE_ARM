#!/bin/sh

##监测iptable分流规则
iptables -t mangle -C PREROUTING -m set ! --match-set chnroute dst -j MARK --set-mark 1 && \
iptables -t mangle -C OUTPUT -m set ! --match-set chnroute dst -j MARK --set-mark 1 || \
/etc/init.d/openvpn restart
