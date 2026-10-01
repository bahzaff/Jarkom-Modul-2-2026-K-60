cat << 'EOF' > /root/soal14.sh
#!/bin/bash
cat << 'CONF' > /etc/apache2/mods-available/remoteip.conf
RemoteIPHeader X-Real-IP
RemoteIPInternalProxy 192.241.2.3
CONF

sed -i 's/%h/%a/g' /etc/apache2/apache2.conf
a2enmod remoteip
service apache2 restart
EOF
chmod +x /root/soal14.sh
/root/soal14.sh