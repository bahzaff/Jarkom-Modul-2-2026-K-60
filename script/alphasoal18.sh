cat << 'EOF' > /root/soal18.sh
#!/bin/bash
DOMAIN="abbey.K-60.com"
RESOLVER="127.0.0.1"

service dnsmasq restart > /dev/null 2>&1

echo "=========================================================="
echo "=== FASE 1: Sebelum Perubahan (IP Asli Abbey) ==="
echo "=========================================================="
dig @$RESOLVER $DOMAIN +noall +answer

echo ""
echo ">> SEKARANG jalankan '/root/soal18.sh' di node PRAB!"
read -p ">> Jika bind9 di PRAB sudah di-reload ke IP fiktif, tekan ENTER..."

echo ""
echo "=========================================================="
echo "=== FASE 2: Saat Perubahan Baru Terjadi (< 15s / Cached) ==="
echo "=========================================================="
dig @$RESOLVER $DOMAIN +noall +answer

echo ""
echo "Menunggu TTL cache habis (menunggu 16 detik)..."
for i in {16..1}; do
    printf "\rSisa waktu TTL: %02d detik... " "$i"
    sleep 1
done
echo -e "\nTTL telah kedaluwarsa (expired)!\n"

echo "=========================================================="
echo "=== FASE 3: Setelah Batas Waktu TTL Habis (IP Fiktif) ==="
echo "=========================================================="
dig @$RESOLVER $DOMAIN +noall +answer
EOF
chmod +x /root/soal18.sh