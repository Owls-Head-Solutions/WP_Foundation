#!/bin/bash

MYSQL="$(which mysql)"

DB_NAME="WP_Foundation"
DB_USER_NAME="WP_User"
DB_PASS="OHSWPFoundationPW"

Q1="CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
Q2="GRANT USAGE ON *.* TO ${DB_USER_NAME}@localhost IDENTIFIED BY '${DB_PASS}';"
Q3="GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO ${DB_USER_NAME}@localhost;"
Q4="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}${Q4}"

$MYSQL -udbuser -p123 -e "$SQL"