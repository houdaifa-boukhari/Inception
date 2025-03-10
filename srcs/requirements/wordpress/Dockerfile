FROM debian:bookworm

# Install required packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    php php-fpm php-mysql wget curl  \
    && rm -rf /var/lib/apt/lists/*

# Install WP-CLI manually
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create WordPress directory
RUN mkdir -p /var/www/html

# Copy setup script
COPY tools/setup_wordpress.sh /setup_wordpress.sh

# Set permissions and execute script
RUN chmod +x /setup_wordpress.sh

# Fix PHP-FPM configuration (Make sure it listens on port 9000)
RUN sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

# Expose PHP-FPM port
EXPOSE 9000

CMD ["bash", "/setup_wordpress.sh"]

