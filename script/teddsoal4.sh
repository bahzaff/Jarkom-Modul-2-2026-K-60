#!/bin/bash

cat > /etc/bind/named.conf <<'EOF'
options {
    directory "/var/cache/bind";
    forwarders { 192.168.122.1; };
    allow-query { any; };
    recursion yes;
};

zone "K-60.com" {
    type slave;
    masters { 192.241.1.2; };
    file "/var/cache/bind/db.K-60.com";
};

zone "1.241.192.in-addr.arpa" {
    type slave;
    masters { 192.241.1.2; };
    file "/var/cache/bind/db.192.241.1";
};

zone "2.241.192.in-addr.arpa" {
    type slave;
    masters { 192.241.1.2; };
    file "/var/cache/bind/db.192.241.2";
};

zone "3.241.192.in-addr.arpa" {
    type slave;
    masters { 192.241.1.2; };
    file "/var/cache/bind/db.192.241.3";
};
EOF

named-checkconf

pkill named 2>/dev/null || true
named -c /etc/bind/named.conf

cat > /etc/resolv.conf <<'EOF'
nameserver 192.241.1.2
nameserver 192.241.1.3
nameserver 192.168.122.1
EOF

echo "DNS Secondary TEDD berhasil dikonfigurasi."