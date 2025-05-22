#!/bin/bash

sleep 3

if [ -f "/var/www/html/wp-config.php" ] && wp core is-installed --path="/var/www/html" --allow-root; then
  echo "WordPress already installed, skipping setup."
  exec php-fpm8.2 -F
fi

echo "SH::Setting up WordPress....."
if [ ! -f "/var/www/html/wp-config.php" ]; then
   mkdir -p /var/www/html

   echo "Bash::Downloading WordPress..."
   wp core download --path="/var/www/html" --allow-root

   echo "Bash::Configing WordPress..."
   wp config create \
     --dbname="${MYSQL_DATABASE}" \
     --dbuser="${MYSQL_USER}" \
     --dbpass="${MYSQL_PASSWORD}" \
     --dbhost="${MYSQL_Host}" \
     --path="/var/www/html" \
     --allow-root

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
   # Redis plugin setup
   echo "SH::Installing Redis plugin..."
   wp plugin install redis-cache --activate --path="/var/www/html" --allow-root

   echo "SH::Configuring Redis constants..."
   wp config set WP_REDIS_HOST "'redis'" --type=constant --path="/var/www/html" --allow-root --raw
   wp config set WP_REDIS_PORT 6379 --type=constant --path="/var/www/html" --allow-root --raw
   wp config set WP_CACHE true --type=constant --path="/var/www/html" --allow-root --raw

   echo "SH::Enabling Redis object cache..."
   wp redis enable --path="/var/www/html" --allow-root



fi
echo "Setup wordpress done...."
chown -R www-data:www-data /var/www/html

exec php-fpm8.2 -F