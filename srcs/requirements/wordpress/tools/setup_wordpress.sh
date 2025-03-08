#!/bin/bash

# Download and extract WordPress
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
rm latest.tar.gz
mv wordpress/* .
rmdir wordpress

# Set correct permissions
chown -R www-data:www-data /var/www/html

export MYSQL_DATABASE="MyDataBase"
export MYSQL_USER="hel-bouk"
export MYSQL_PASSWORD="123458796"
# Create wp-config.php
cat <<EOF > /var/www/html/wp-config.php
<?php
define( 'DB_NAME', getenv('MYSQL_DATABASE') );
define( 'DB_USER', getenv('MYSQL_USER') );
define( 'DB_PASSWORD', getenv('MYSQL_PASSWORD') );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

\$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';
EOF

echo "WordPress installed successfully!"
