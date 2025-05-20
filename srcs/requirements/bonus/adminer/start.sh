#!/bin/bash

# run in the background need for cgi 
php-fpm8.2 &

# run lighttpd in the foreground
lighttpd -D -f /etc/lighttpd/lighttpd.conf
