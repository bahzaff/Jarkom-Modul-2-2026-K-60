cat << 'EOF' > /root/soal14.sh
#!/bin/bash
cat << 'CONF' > /etc/nginx/conf.d/realip.conf
set_real_ip_from 192.241.2.2;
real_ip_header X-Real-IP;
CONF

service nginx restart
EOF
chmod +x /root/soal14.sh
/root/soal14.sh