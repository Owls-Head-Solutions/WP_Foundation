
OHS WordPress Foundation virtual machine

This package will automatically build a vagrant virtual machine on Ubuntu.
This was built for use with PHP Storm but it should work in other Vagrant
environments.

When Vagrant is finished running you should have a complete virtual machine with
a WordPress DB, WordPress and XDebug all installed and configured.

********************************
Important things to know
********************************

********************************
Requirements
********************************
Oracle Virtual Box
Vagrant
PHP

********************************
Recommended
********************************
PHP Storm 8+

********************************
Configuration of Machine
********************************
The virtual machine configuration is mostly handled in the config.yaml file
at the root of this package. Set the IP address of the virtual machine on
line 11 of config.yaml:

private_network: 192.168.56.102

When vagrant is finished running the inital setup you may view your website
from the host machine at http://192.168.56.102. If you have multiple machines make
sure to assign them different IP addresses

********************************
Configuration of
Database and WordPress
********************************
The database table for WordPress is configured in the following 2 files

puphpet/files/exec-once/a_install_wp_db.sh
This file installs the database. At the top of the page are the following variable settings:

DB_NAME="WP_Foundation"
DB_USER_NAME="WP_User"
DB_PASS="OHSWPFoundationPW"

Set these variables to values that make sense for you

puphpet/files/exec-once/b_install_wp.sh
This file installs WP-CLI and WordPress. At the top of the page are the following variable settings:

DB_NAME="WP_Foundation"
DB_USER_NAME="WP_User"
DB_PASS="OHSWPFoundationPW"

WP_TITLE="WPFoundation"
WP_USER="admin"
WP_USER_PASS="admin"
WP_USER_EMAIL="admin@admin.com"

The DB_XXX variables in this file must match the values from the /a_install_wp_db.sh file.
If you changed them in a_install_wp_db.sh then you must set them to match in b_install_wp.sh

The WP_XXX variables will set your WordPress title and create the administrative user. Set
these values appropriately.

********************************
Getting Started
********************************

1.) Create a new project with PHP Storm
2.) Copy the contents of this package into the root of the project folder
3.) If Vagrant is not already installed and configured for PHP Storm, do so now
4.) Run Vagrant Up from the Tools->Vagrant menu
5.) Go have coffee, it takes a while, at least 10 minutes on my machine
6.) When finished, the "html" folder will be populated with WordPress files. This folder is
automatically shared to the virtual machine so any changes made here will manifest instantly
on your virtual machine
7.) Open a browser on your host machine (the real machine) and browse to http://192.168.56.102 or
whatever your machine's IP was set to in config.yaml
8.) Start developing!

********************************
Debugging
********************************
This system installs XDebug into the virtual dev environment. If you have XDebug setup
on your PHP Storm instance then it is pretty easy do efficient "break point" debugging.
Turn on your debugger in PHP Storm (top right corner), set the debugger cookie in your browser
with the bookmarklets here: https://www.jetbrains.com/phpstorm/marklets/, then
set some breakpoints. PHP Storm will notify you of a new connection and pause on the code as
it executes.
