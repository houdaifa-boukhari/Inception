#!/bin/bash

# Start php-fpm in the background
php-fpm8.2 &

# Start lighttpd in the foreground
lighttpd -D -f /etc/lighttpd/lighttpd.conf
