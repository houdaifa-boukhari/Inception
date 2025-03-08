FROM debian:bookworm

# Update and install necessary packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    php php-fpm php-mysql php-cli php-mbstring php-xml wget unzip curl \
    mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Create WordPress directory
RUN mkdir -p /var/www/html

# Copy installation script
COPY tools/setup_wordpress.sh /setup_wordpress.sh

# Set permissions and execute script
RUN chmod +x /setup_wordpress.sh && /setup_wordpress.sh

# Expose PHP-FPM port
EXPOSE 9000

# CMD ["php-fpm", "-F"]
CMD [ "yes" ]
