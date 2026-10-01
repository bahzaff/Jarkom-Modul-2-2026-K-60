cat << 'EOF' > /root/soal11.sh
#!/bin/bash
cat << 'CONF' > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    ServerName [www.K-60.com](https://www.K-60.com)
    ServerAlias penny.K-60.com

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
chmod +x /root/soal11.sh
/root/soal11.sh
