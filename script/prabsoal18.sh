cat << 'EOF' > /root/soal18.sh
#!/bin/bash
ZONE_FILE="/etc/bind/db.K-60.com"
FICTIVE_IP="192.241.99.99"

sed -i '/abbey.*IN.*A/d' "$ZONE_FILE"
echo "abbey       15  IN  A   $FICTIVE_IP" >> "$ZONE_FILE"

OLD_SERIAL=$(awk '/SOA/{getline; print $1}' "$ZONE_FILE" | tr -cd '0-9')
if [ -n "$OLD_SERIAL" ]; then
    NEW_SERIAL=$((OLD_SERIAL + 1))
    sed -i "s/$OLD_SERIAL/$NEW_SERIAL/" "$ZONE_FILE"
fi

named-checkzone K-60.com "$ZONE_FILE"
service named restart || /etc/init.d/named restart
rndc reload 2>/dev/null || true
EOF
chmod +x /root/soal18.sh