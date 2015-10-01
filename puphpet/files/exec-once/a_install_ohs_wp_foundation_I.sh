#!/bin/bash

#determin mysql binary location
MYSQL="$(which mysql)"

#setup variable values
DB_NAME="WP_Foundation"
DB_USER_NAME="WP_User"
DB_PASS="OHSWPFoundationPW"

WP_TITLE="WPFoundation"
WP_USER="admin"
WP_USER_PASS="admin"
WP_USER_EMAIL="admin@admin.com"
WP_IP="192.168.56.102"

#create mysql db scrilpt
Q1="CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
Q2="GRANT USAGE ON *.* TO ${DB_USER_NAME}@localhost IDENTIFIED BY '${DB_PASS}';"
Q3="GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO ${DB_USER_NAME}@localhost;"
Q4="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}"

#create mysql table
$MYSQL -udbuser -p123 -e "$SQL"

#download and install wp-cli and wp
cd /tmp
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
cp wp-cli.phar /usr/local/bin/wp
chmod +x /usr/local/bin/wp
cd /var/www/html
wp core download --allow-root
wp core config --allow-root --path='/var/www/html' --dbname=${DB_NAME} --dbuser=${DB_USER_NAME} --dbpass=${DB_PASS}
wp core install --allow-root --url=http://${WP_IP} --title=${WP_TITLE} --admin_user=${WP_USER} --admin_password=${WP_USER_PASS} --admin_email=${WP_USER_EMAIL}

#configure wordpress
wp plugin delete --allow-root akismet hello
wp plugin install --allow-root advanced-custom-fields --activate
wp plugin install --allow-root wp-statistics --activate

wp post delete --allow-root $(wp post list --allow-root --post_type='post' --format=ids)
wp post delete --allow-root $(wp post list --allow-root --post_type='post' --post_status=trash --format=ids)

wp post delete --allow-root $(wp post list --allow-root --post_type='page' --format=ids)
wp post delete --allow-root $(wp post list --allow-root --post_type='page' --post_status=trash --format=ids)

wp post create --allow-root --post_type=page --post_title='Home' --post_status=publish --post_author=$(wp user get --allow-root ${WP_USER} --field=ID --format=ids)

wp option update --allow-root show_on_front 'page'
wp option update --allow-root page_on_front $(wp post list --allow-root --post_type=page --post_status=publish --posts_per_page=1 --pagename=home --field=ID --format=ids)

wp rewrite structure --allow-root '/%postname%/' --hard
wp rewrite flush --allow-root --hard

#clean up leftover apache sample file
sudo rm /var/www/html/index.html

#Install Node & npm
sudo apt-get update
sudo apt-get --force-yes --yes install nodejs
sudo apt-get --force-yes --yes install npm

#Install Screen
sudo apt-get --force-yes --yes install screen
sudo rm /etc/screenrc
sudo cp /vagrant/puphpet/files/screenrc /etc

#Install Grunt & SASS, setup new theme folder
cd /var/www/html
cp /vagrant/puphpet/files/package.json .
cp /vagrant/puphpet/files/Gruntfile.js .


sed -i -e "s,<PATH_TO_THEME>,${WP_TITLE}_Theme,g" /var/www/html/Gruntfile.js
sed -i -e "s,<PJSON_PROJ_NAME>,${WP_TITLE},g" /var/www/html/package.json

npm install -g grunt-cli
npm install grunt --save-dev --no-bin-links
npm install grunt-contrib-sass --save-dev --no-bin-links
npm install grunt-contrib-watch --save-dev --no-bin-links
npm install autoprefixer --save-dev --no-bin-links
npm install grunt-autoprefixer --save-dev --no-bin-links
npm install grunt-postcss --save-dev --no-bin-links


mkdir /var/www/html/wp-content/themes/${WP_TITLE}_Theme
#mkdir /var/www/html/wp-content/themes/${WP_TITLE}_Theme/style
cp /vagrant/puphpet/files/style.scss /var/www/html/wp-content/themes/${WP_TITLE}_Theme

#fix for "usr/bin/env: node: No such file or directory"
sudo ln -s /usr/bin/nodejs /usr/bin/node

#once we are done with this script, copy this script file out to files so it never runs again - also copy in the new script used to clone the new project
cp /vagrant/puphpet/files/a_install_ohs_wp_foundation_II.sh /vagrant/puphpet/files/exec-once/a_install_ohs_wp_foundation_II.sh

sed -i -e "s,<WPF_DB_NAME>,${DB_NAME},g" /vagrant/puphpet/files/exec-once/a_install_ohs_wp_foundation_II.sh
sed -i -e "s,<WPF_DB_USER>,${DB_USER_NAME},g" /vagrant/puphpet/files/exec-once/a_install_ohs_wp_foundation_II.sh
sed -i -e "s,<WPF_DB_PASS>,${DB_PASS},g" /vagrant/puphpet/files/exec-once/a_install_ohs_wp_foundation_II.sh

sed -i -e "s,<WPF_WP_TITLE>,${WP_TITLE},g" /vagrant/puphpet/files/exec-once/a_install_ohs_wp_foundation_II.sh
sed -i -e "s,<WPF_WP_USER>,${WP_USER},g" /vagrant/puphpet/files/exec-once/a_install_ohs_wp_foundation_II.sh
sed -i -e "s,<WPF_WP_PSWD>,${WP_USER_PASS},g" /vagrant/puphpet/files/exec-once/a_install_ohs_wp_foundation_II.sh
sed -i -e "s,<WPF_WP_EMAIL>,${WP_USER_EMAIL},g" /vagrant/puphpet/files/exec-once/a_install_ohs_wp_foundation_II.sh
sed -i -e "s,<WPF_WP_IP>,${WP_IP},g" /vagrant/puphpet/files/exec-once/a_install_ohs_wp_foundation_II.sh

#create hte flag to let the system know foundation I has been run
cp /vagrant/puphpet/files/ohs_flag_I.txt /var/www/html/ohs_flag_I.txt