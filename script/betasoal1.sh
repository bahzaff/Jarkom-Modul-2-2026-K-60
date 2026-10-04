#!/bin/bash
ip link set eth0 up
ip addr replace 192.241.4.3/24 dev eth0
ip route replace default via 192.241.4.1 dev eth0
echo "Konfigurasi Soal 1 beta selesai."