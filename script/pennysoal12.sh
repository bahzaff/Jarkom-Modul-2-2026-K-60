cat << 'EOF' > /root/soal12.sh
#!/bin/bash
htpasswd -cb /etc/apache2/.htpasswd prabs pakar_pinter_jadi_gob***

cat << 'CONF' > /etc/apache2/conf-available/admin-auth.conf
<Location /admin>
    AuthType Basic
    AuthName "Restricted Vault Admin Area"
    AuthUserFile /etc/apache2/.htpasswd
    Require valid-user
</Location>
CONF

a2enconf admin-auth
service apache2 restart
EOF
chmod +x /root/soal12.sh
/root/soal12.sh