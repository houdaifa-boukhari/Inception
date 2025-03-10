#!/bin/bash

echo "Starting MariaDB service..."
mysqld_safe --datadir=/var/lib/mysql &

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h localhost --silent; do
    sleep 2
done

echo "Updating MariaDB configuration..."
sed -i "s/^bind-address\s*=.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

echo "Securing MariaDB installation..."
mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY 'secure_root_password';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

echo "Creating database and user..."
mysql -u root -p'secure_root_password' <<EOF
CREATE DATABASE IF NOT EXISTS mydatabase;
CREATE USER IF NOT EXISTS 'hel-bouk'@'%' IDENTIFIED BY 'zel-bouk@013251';
GRANT ALL PRIVILEGES ON mydatabase.* TO 'hel-bouk'@'%';
FLUSH PRIVILEGES;
EOF

echo "MariaDB setup completed!"

# Stop MariaDB background service before restarting in foreground
mysqladmin -u root -p'secure_root_password' shutdown

# Start MariaDB in the foreground
exec mysqld_safe --datadir=/var/lib/mysql
