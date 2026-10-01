cat << 'EOF' > /root/soal13.sh
#!/bin/bash
cat << 'CONF' > /etc/nginx/sites-available/default
upstream core_backend {
    server 192.241.3.4:80;
    server 192.241.3.5:80;
}

server {
    listen 80;
    server_name abbey.K-60.com 192.241.2.2;
    return 302 [http://static.K-60.com](http://static.K-60.com)$request_uri;
}

server {
    listen 80;
    server_name static.K-60.com;

    location / {
        proxy_pass http://core_backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
CONF

service nginx restart
EOF
chmod +x /root/soal13.sh
/root/soal13.sh