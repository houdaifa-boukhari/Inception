#!/bin/bash

sleep 10

echo "SH::Setting up WordPress..."
if [ ! -f "/var/www/html/wp-config.php" ]; then
#   # Create directory for WordPress if it doesn't exist
  mkdir -p /var/www/html

  # Download WordPress
  echo "SH::Downloading WordPress..."
  wp core download --path="/var/www/html" --allow-root


  # Create wp-config.php with database credentials
  wp config create \
     --dbname="${MYSQL_DATABASE}" \
     --dbuser="${MYSQL_USER}" \
     --dbpass="${MYSQL_PASSWORD}" \
     --dbhost="mariadb" \
     --path="/var/www/html" \
     --allow-root

  # Install WordPress with the given admin credentials and site details
  echo "SH::Installing WordPress..."
  wp core install \
     --url="hel-bouk.42.fr" \
     --title="My site" \
     --admin_user="admin" \
     --admin_password="admin" \
     --admin_email="admin@gmail.com" \
     --path="/var/www/html" \
     --allow-root

   # Create user
#    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
#       --role="subscriber" \
#       --user_pass="${WP_USER_PASSWORD}" \
#       --path="/var/www/html" \
#       --allow-root


fi

chown -R www-data:www-data /var/www/html

exec php-fpm8.2 -F