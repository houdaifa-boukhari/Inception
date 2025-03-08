#!/bin/bash

# Load environment variables
# source /usr/local/bin/.env

MYSQL_ROOT_PASSWORD=secure_root_password
DB_NAME=mydatabase
DB_USER=hel-bouk
DB_PASS=zel-bouk@013251

# Check if MariaDB is already running
if pgrep -x "mysqld" > /dev/null; then
    echo "MariaDB is already running."
else
    echo "Starting MariaDB service..."
    mysqld_safe --datadir=/var/lib/mysql &
    sleep 5  # Wait for MariaDB to initialize
fi

# Secure MariaDB installation
echo "Securing MariaDB installation..."
mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

# Create database and user
echo "Creating database and user..."
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "MariaDB setup completed!"

# Keep MariaDB running in the foreground
# wait
