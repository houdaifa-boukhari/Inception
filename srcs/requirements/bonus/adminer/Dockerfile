FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    php php-mysqli php-fpm wget unzip lighttpd

RUN mkdir -p /var/www/html && \
    wget -O /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php && \
    mv /var/www/html/index.php /var/www/html/adminer.php && \
    chmod -R 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

COPY lighttpd.conf /etc/lighttpd/lighttpd.conf

EXPOSE 8080

# Start PHP-FPM and lighttpd together using a simple script
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
