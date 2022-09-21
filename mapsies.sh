#!/bin/bash

###the data for iframe
ip="$(grep "Invalid" /var/log/auth.log* | sed -e 's/.*from\(.*\)port.*/\1/' | sort | uniq -c  | sort | tail -1  | awk '{print $2}')"
attempts="$(grep "Invalid" /var/log/auth.log* | sed -e 's/.*from\(.*\)port.*/\1/' | sort | uniq -c  | sort | tail -1  | awk '{print $1}')"
attackerip="$(grep "Invalid" /var/log/auth.log | tail -1 | grep -Eoa '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')"
