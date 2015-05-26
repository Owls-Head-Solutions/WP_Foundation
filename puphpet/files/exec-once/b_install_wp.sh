#!/bin/bash

DB_NAME="WP_Foundation"
DB_USER_NAME="WP_User"
DB_PASS="OHSWPFoundationPW"

cd /tmp
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
cp wp-cli.phar /usr/local/bin/wp
chmod +x /usr/local/bin/wp
cd /var/www/html
wp core download --allow-root
wp core config --allow-root --path='/var/www/html' --dbname=${DB_NAME} --dbuser=${DB_USER_NAME} --dbpass=${DB_PASS}
wp core install --allow-root --url=http://localhost --title=WPFoundation --admin_user=admin --admin_password=admin --admin_email=test@test.com
rm index.html