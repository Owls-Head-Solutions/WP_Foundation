#!/bin/bash

DB_NAME="WP_Foundation"
DB_USER_NAME="WP_User"
DB_PASS="OHSWPFoundationPW"

WP_TITLE="WPFoundation"
WP_USER="admin"
WP_USER_PASS="admin"
WP_USER_EMAIL="admin@admin.com"
WP_IP="192.168.56.102"

cd /tmp
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
cp wp-cli.phar /usr/local/bin/wp
chmod +x /usr/local/bin/wp
cd /var/www/html
wp core download --allow-root
wp core config --allow-root --path='/var/www/html' --dbname=${DB_NAME} --dbuser=${DB_USER_NAME} --dbpass=${DB_PASS}
wp core install --allow-root --url=http://${WP_IP} --title=${WP_TITLE} --admin_user=${WP_USER} --admin_password=${WP_USER_PASS} --admin_email=${WP_USER_EMAIL}
rm index.html