#!/bin/bash

mkdir -p /var/www/core

cat > /var/www/core/index.php <<'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Core K-60 - Oblada</title>
</head>
<body>
    <h1>Core K-60</h1>
    <p>Halaman beranda dari Oblada.</p>
    <a href="/profil">Profil</a>
</body>
</html>
EOF

cat > /var/www/core/profil.php <<'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Profil Core K-60</title>
</head>
<body>
    <h1>Profil Core K-60</h1>
    <p>Halaman profil dari Oblada.</p>
</body>
</html>
EOF

cat > /etc/nginx/sites-available/core <<'EOF'
server {
    listen 80;
    server_name oblada.K-60.com core.K-60.com;

    root /var/www/core;
    index index.php;

    location = /profil {
        rewrite ^/profil$ /profil.php last;
    }

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.4-fpm.sock;
    }
}
EOF

ln -sf /etc/nginx/sites-available/core /etc/nginx/sites-enabled/core
rm -f /etc/nginx/sites-enabled/default

nginx -t

pkill nginx 2>/dev/null || true
nginx

echo "Konfigurasi Soal 10 Oblada selesai."