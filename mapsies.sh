#!/bin/bash

###the data for iframe

ip="$(grep "Invalid" /var/log/auth.log* | sed -e 's/.*from\(.*\)port.*/\1/' | sort | uniq -c  | sort | tail -1  | awk '{print $2}')"
attempts="$(grep "Invalid" /var/log/auth.log* | sed -e 's/.*from\(.*\)port.*/\1/' | sort | uniq -c  | sort | tail -1  | awk '{print $1}')"
attackerip="$(grep "Invalid" /var/log/auth.log | tail -1 | grep -Eoa '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')"

echo "<h6>" > /var/www/html/theworst.html
echo The most malicious attempts, at this web server, originate from address $ip. That IP has attempted $attempts times to hack this webserver. Others are listed below. >> /var/www/html/theworst.html
echo "<hr>" >> /var/www/html/theworst.html
grep "Invalid" /var/log/auth.log | sed -e 's/.*]:\(.*\)port.*/\1/' | tail -n 100 >> /var/www/html/theworst.html

echo "</h6>" >> /var/www/html/theworst.html

chmod 655 /var/www/html/theworst.html


###attack map

if grep -q $attackerip /tmp/ip.txt; then

sort /tmp/ip.txt > /var/www/html/attacker_ip_list.txt

exit 0

else

echo $attackerip >> /tmp/ip.txt

cp /tmp/ip.txt /var/www/html/attacker_ip_list.txt

chmod 655 /var/www/html/attacker_ip_list.txt

python3 /root/PyGeoIpMap/pygeoipmap.py -i /tmp/ip.txt --service m --db /root/GeoLite2-City_20191029/GeoLite2-City.mmdb -o /var/www/html/images/images/theworst.png

fi

exit 0
