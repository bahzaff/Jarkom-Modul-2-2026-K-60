cat << 'EOF' > /root/soal15.sh
#!/bin/bash
mkdir -p /var/www/eternal
cat << 'PHP' > /var/www/eternal/index.php
<h1>Halo dari /eternal di Penny</h1>
<p>PHP Version: <?php echo phpversion(); ?></p>
PHP

cat << 'CONF' > /etc/apache2/conf-available/eternal.conf
ProxyPass /eternal !
Alias /eternal /var/www/eternal
<Directory /var/www/eternal>
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
    DirectoryIndex index.php
</Directory>
CONF

a2enmod php* 2>/dev/null || true
a2enconf eternal
service apache2 restart
EOF
chmod +x /root/soal15.sh
/root/soal15.sh