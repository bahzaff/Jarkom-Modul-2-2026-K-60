cat << 'EOF' > /root/soal15.sh
#!/bin/bash
mkdir -p /var/www/orion
cat << 'HTML' > /var/www/orion/index.html
<h1>Halo dari /orion di Abbey</h1>
<p>Halaman ini disajikan murni statis tanpa rendering PHP.</p>
HTML

sed -i '/location \/ {/i \
    location /orion { \
        alias /var/www/orion; \
        index index.html; \
    }' /etc/nginx/sites-available/default

service nginx restart
EOF
chmod +x /root/soal15.sh
/root/soal15.sh