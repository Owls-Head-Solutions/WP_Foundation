#!/bin/bash

if [ -f /var/www/html/ohs_flag.txt ]; then

    #determin mysql binary location
    MYSQL="$(which mysql)"

    #setup variable values
    DB_NAME="<WPF_DB_NAME>"
    DB_USER_NAME="<WPF_DB_USER>"
    DB_PASS="<WPF_DB_PASS>"

    WP_TITLE="<WPF_WP_TITLE>"
    WP_USER="<WPF_WP_USER>"
    WP_USER_PASS="<WPF_WP_PSWD>"
    WP_USER_EMAIL="<WPF_WP_EMAIL>"
    WP_IP="<WPF_WP_IP>"

    #create mysql db scrilpt
    Q1="CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
    Q2="GRANT USAGE ON *.* TO ${DB_USER_NAME}@localhost IDENTIFIED BY '${DB_PASS}';"
    Q3="GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO ${DB_USER_NAME}@localhost;"
    Q4="FLUSH PRIVILEGES;"
    SQL="${Q1}${Q2}${Q3}${Q4}"

    #create mysql table
    $MYSQL -udbuser -p123 -e "$SQL"

    #look for and import SQL file
    mysql -u ${DB_USER_NAME} -p${DB_PASS} ${DB_NAME} < /vagrant/puphpet/files/backup_latest.sql
    #import  file

    #Install and configure Node, npm, grunt-cli, screen and phpmyadmin
    sudo apt-get update

    sudo apt-get --force-yes --yes install screen
    sudo apt-get --force-yes --yes install nodejs
    sudo apt-get --force-yes --yes install npm
    sudo npm install -g grunt-cli
    sudo ln -s /usr/bin/nodejs /usr/bin/node
    sudo rm /etc/screenrc
    sudo cp /vagrant/puphpet/files/screenrc /etc


    sed -i -e "s,<XXXXX>,-Foundation II has been completed,g"
    mv /var/www/html/ohs_flag_II.txt

    service apache2 reload
fi