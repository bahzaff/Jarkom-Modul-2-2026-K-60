#!/bin/bash

mkdir -p /var/www/html/arsip

echo "Arsip dari Obladi" > /var/www/html/arsip/obladi.txt
echo "Dokumen Vault K-60" > /var/www/html/arsip/vault.txt

cat > /etc/apache2/conf-available/arsip.conf <<'EOF'
<Directory /var/www/html/arsip>
    Options +Indexes
    AllowOverride None
    Require all granted
</Directory>
EOF

a2enmod autoindex
a2enconf arsip

apache2ctl configtest

pkill apache2 2>/dev/null || true
rm -f /var/run/apache2/apache2.pid
rm -f /run/apache2/apache2.pid
mkdir -p /run/apache2

apache2ctl start

echo "Konfigurasi Soal 9 Obladi selesai."