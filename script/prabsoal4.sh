#!/bin/bash

cat > /etc/bind/named.conf <<'EOF'
options {
    directory "/var/cache/bind";
    forwarders { 192.168.122.1; };
    allow-query { any; };
    recursion yes;
};

zone "K-60.com" {
    type master;
    file "/etc/bind/db.K-60.com";
    allow-transfer { 192.241.1.3; };
    also-notify { 192.241.1.3; };
};

zone "1.241.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.241.1";
    allow-transfer { 192.241.1.3; };
};

zone "2.241.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.241.2";
    allow-transfer { 192.241.1.3; };
};

zone "3.241.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.241.3";
    allow-transfer { 192.241.1.3; };
};
EOF

cat > /etc/bind/db.K-60.com <<'EOF'
$TTL 604800
@ IN SOA prab.K-60.com. root.K-60.com. (
    2026093004
    604800
    86400
    2419200
    604800
)

@       IN NS prab.K-60.com.
@       IN NS tedd.K-60.com.

@       IN A 192.241.3.2

prab    IN A 192.241.1.2
tedd    IN A 192.241.1.3
alpha   IN A 192.241.4.2
beta    IN A 192.241.4.3
gamma   IN A 192.241.4.4
delta   IN A 192.241.5.2
epsilon IN A 192.241.5.3
abbey   IN A 192.241.2.2
penny   IN A 192.241.3.2
obladi  IN A 192.241.1.4
desmond IN A 192.241.1.5
oblada  IN A 192.241.1.6
molly   IN A 192.241.1.7

vault   IN A 192.241.1.4
vault   IN A 192.241.1.5
core    IN A 192.241.1.6
core    IN A 192.241.1.7

www     IN CNAME penny.K-60.com.
static  IN CNAME abbey.K-60.com.
EOF

cat > /etc/bind/db.192.241.1 <<'EOF'
$TTL 604800
@ IN SOA prab.K-60.com. root.K-60.com. (
    2026093001
    604800
    86400
    2419200
    604800
)

@ IN NS prab.K-60.com.
@ IN NS tedd.K-60.com.

2 IN PTR prab.K-60.com.
3 IN PTR tedd.K-60.com.
4 IN PTR obladi.K-60.com.
5 IN PTR desmond.K-60.com.
6 IN PTR oblada.K-60.com.
7 IN PTR molly.K-60.com.
EOF

cat > /etc/bind/db.192.241.2 <<'EOF'
$TTL 604800
@ IN SOA prab.K-60.com. root.K-60.com. (
    2026093001
    604800
    86400
    2419200
    604800
)

@ IN NS prab.K-60.com.
@ IN NS tedd.K-60.com.

2 IN PTR abbey.K-60.com.
EOF

cat > /etc/bind/db.192.241.3 <<'EOF'
$TTL 604800
@ IN SOA prab.K-60.com. root.K-60.com. (
    2026093001
    604800
    86400
    2419200
    604800
)

@ IN NS prab.K-60.com.
@ IN NS tedd.K-60.com.

2 IN PTR penny.K-60.com.
EOF

named-checkconf
named-checkzone K-60.com /etc/bind/db.K-60.com

pkill named 2>/dev/null || true
named -c /etc/bind/named.conf

cat > /etc/resolv.conf <<'EOF'
nameserver 192.241.1.2
nameserver 192.241.1.3
nameserver 192.168.122.1
EOF

echo "DNS Primary PRAB berhasil dikonfigurasi."