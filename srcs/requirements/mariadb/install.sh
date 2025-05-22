#!/bin/bash

echo "Starting MariaDB service..."

set -e

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    mysqld_safe &
    
until mysqladmin ping --silent; do
    sleep 2
done

    mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
DELETE FROM mysql.user WHERE User='';
FLUSH PRIVILEGES;
EOF

    mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
fi

exec mysqld_safe