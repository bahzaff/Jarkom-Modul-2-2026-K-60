cat << 'EOF' > /root/soal13.sh
#!/bin/bash
cat << 'CONF' > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    ServerName penny.K-60.com
    ServerAlias 192.241.2.3
    RewriteEngine On
    RewriteRule ^(.*)$ [http://www.K-60.com](http://www.K-60.com)$1 [R=301,L]
</VirtualHost>

<VirtualHost *:80>
    ServerName [www.K-60.com](https://www.K-60.com)
    <Proxy balancer://vaultcluster>
        BalancerMember [http://192.241.3.2:80](http://192.241.3.2:80)
        BalancerMember [http://192.241.3.3:80](http://192.241.3.3:80)
    </Proxy>
    RequestHeader set X-Real-IP "%{REMOTE_ADDR}s"
    ProxyPreserveHost On
    ProxyPass / balancer://vaultcluster/
    ProxyPassReverse / balancer://vaultcluster/
</VirtualHost>
CONF

service apache2 restart
EOF
chmod +x /root/soal13.sh
/root/soal13.sh