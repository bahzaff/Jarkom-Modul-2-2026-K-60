#!/bin/bash

ip link set eth0 up
ip addr replace 192.168.122.2/24 dev eth0
ip route replace default via 192.168.122.1 dev eth0

echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -t nat -C POSTROUTING -s 192.241.0.0/16 -o eth0 -j MASQUERADE 2>/dev/null || \
iptables -t nat -A POSTROUTING -s 192.241.0.0/16 -o eth0 -j MASQUERADE

echo "Konfigurasi Soal 2 rootkit selesai."