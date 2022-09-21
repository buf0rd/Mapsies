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
