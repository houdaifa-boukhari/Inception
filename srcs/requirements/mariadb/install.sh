#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update -y

# Install MariaDB server
echo "Installing MariaDB server..."
sudo apt install -y mariadb-server

# Enable and start MariaDB service
echo "Enabling and starting MariaDB service..."
sudo systemctl enable mariadb
sudo systemctl start mariadb

# Secure MariaDB installation (Automated)
echo "Securing MariaDB installation..."
sudo mysql_secure_installation <<EOF

y
zel-bouk@013251
zel-bouk@013251
y
y
y
y
y
EOF

# Create a database and a user
DB_NAME="mydatabase"
DB_USER="hel-bouk"
DB_PASS="zel-bouk@013251"

echo "Creating database and user..."
sudo mysql -uroot -p'rootpassword' <<EOF
CREATE DATABASE $DB_NAME;
CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';
FLUSH PRIVILEGES;
EOF

echo "MariaDB installation and configuration completed!"
