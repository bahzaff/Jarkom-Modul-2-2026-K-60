#!/bin/bash
ip link set eth0 up
ip addr replace 192.241.2.2/24 dev eth0
ip route replace default via 192.241.2.1 dev eth0
echo "Konfigurasi Soal 1 abbey selesai."