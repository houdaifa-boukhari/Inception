#!/bin/bash

sleep 3

echo "SH::Setting up WordPress....."
if [ ! -f "/var/www/html/wp-config.php" ]; then
  # Create directory for WordPress if it doesn't exist
  mkdir -p /var/www/html

  # Download WordPress
  echo "Bash::Downloading WordPress..."
  wp core download --path="/var/www/html" --allow-root

   echo "Bash::Configing WordPress..."
  # Create wp-config.php with database credentials
  wp config create \
     --dbname="${MYSQL_DATABASE}" \
     --dbuser="${MYSQL_USER}" \
     --dbpass="${MYSQL_PASSWORD}" \
     --dbhost="${MYSQL_Host}" \
     --path="/var/www/html" \
     --allow-root

  # Install WordPress with the given admin credentials and site details
  echo "SH::Installing WordPress..."
  wp core install \
     --url="${WP_URL}" \
     --title="${WP_TITLE}" \
     --admin_user="${WP_ADMIN}" \
     --admin_password="${WP_ADMIN_PASS}" \
     --admin_email="${WP_ADMIN_MAIL}" \
     --path="/var/www/html" \
     --allow-root
   echo "SH::Creating additional WordPress user..."
    wp user create "${WP_USER}" "${WP_MAIL_USER}" \
        --role=editor \
        --user_pass="${WP_PASS}" \
        --path="/var/www/html" \
        --allow-root
fi
echo "Setup wordpress done...."
chown -R www-data:www-data /var/www/html

exec php-fpm8.2 -F