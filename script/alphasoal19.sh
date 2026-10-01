cat << 'EOF' > /root/soal19.sh
#!/bin/bash
echo "=========================================="
echo " UJI CNAME RECORD: outbound.K-60.com"
echo "=========================================="
echo "--- Menggunakan host ---"
host -t CNAME outbound.K-60.com

echo ""
echo "--- Menggunakan dig ---"
dig outbound.K-60.com +noall +answer

echo ""
echo "--- Resolusi Alamat Penuh ---"
host outbound.K-60.com

echo ""
echo "--- Pengujian Curl HTTP ---"
curl -s [http://outbound.K-60.com](http://outbound.K-60.com) | head -n 12
EOF
chmod +x /root/soal19.sh
/root/soal19.sh