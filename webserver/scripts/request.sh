#!/bin/bash

grep GET /var/log/apache2/access.log | cut -d[ -f2 | cut -d] -f1 | awk -F: '{print $2":00"}' | sort -n | uniq -c > /var/www/html/request.txt