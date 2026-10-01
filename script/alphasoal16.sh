cat << 'EOF' > /root/soal16.sh
#!/bin/bash
echo "=========================================================="
echo " STRESS TEST: [www.K-60.com](https://www.K-60.com) (250 req / 10 concurrent)"
echo "=========================================================="
ab -n 250 -c 10 [http://www.K-60.com/](http://www.K-60.com/)

echo ""
echo "=========================================================="
echo " STRESS TEST: static.K-60.com (250 req / 10 concurrent)"
echo "=========================================================="
ab -n 250 -c 10 [http://static.K-60.com/](http://static.K-60.com/)
EOF
chmod +x /root/soal16.sh
/root/soal16.sh