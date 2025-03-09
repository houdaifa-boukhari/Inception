#!/bin/bash

echo "Starting MariaDB service..."
mysqld_safe --datadir=/var/lib/mysql &

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h localhost --silent; do
    sleep 2
done

echo "Securing MariaDB installation..."
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

echo "Creating database and user..."
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "MariaDB setup completed!"

# Stop MariaDB service before restarting in foreground
mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Start MariaDB in the foreground
exec mysqld_safe --datadir=/var/lib/mysql
