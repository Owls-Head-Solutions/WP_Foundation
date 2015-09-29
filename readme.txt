
OHS WordPress Foundation virtual machine

This package will automatically build a vagrant virtual machine on Ubuntu.
This was built for use with PHP Storm but it should work in other Vagrant
environments.

When Vagrant is finished running you should have a complete virtual machine with
a WordPress DB, WordPress, Grunt, Sass and XDebug all installed and configured.

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
line 11 of config.yaml. Make sure to set it to a unique IP address that is
unused by other virtual machines.

private_network: 192.168.56.102

Set the hostname to be unique in case you have multiple Vagrant machines running. Failure to set a unique hostame
may result in failure to successfully run Vagrant

On or near line 6 of config.yaml
hostname: local.wpfoundation

When vagrant is finished running the inital setup you may view your website
from the host machine at http://192.168.56.102 (or whatever IP address you chose). If you have multiple machines make
sure to assign them different IP addresses


********************************
Configuration of
Database and WordPress
********************************
The database table for WordPress is configured in the following 2 files

puphpet/files/exec-once/a_install_wp_foundation.sh
This file installs the database, wp-cli, wp and various other necessary components:

DB_NAME="WP_Foundation"
DB_USER_NAME="WP_User"
DB_PASS="OHSWPFoundationPW"

WP_TITLE="WPFoundation"
WP_USER="admin"
WP_USER_PASS="admin"
WP_USER_EMAIL="admin@admin.com"
WP_IP="192.168.56.102"

Set these variables to values that make sense for you

The DB_XXX variables in this file must match the values from the /a_install_wp_db.sh file.
If you changed them in a_install_wp_db.sh then you must set them to match in b_install_wp.sh

The WP_XXX variables will set your WordPress title and create the administrative user. Set
these values appropriately.

Make sure the WP_IP value matches the IP of the machine in the config.yaml file.
********************************
Getting Started
********************************

First Run
1.) Create a new project with PHP Storm
2.) Copy the contents of this package into the root of the project folder
3.) If Vagrant is not already installed and configured for PHP Storm, do so now
4.) Adjust configurations mentioned above
5.) Run Vagrant Up from the Tools->Vagrant menu
6.) Go have coffee, it takes a while, at least 10 minutes on my machine
7.) When finished, the "html" folder will be populated with WordPress files. This folder is
automatically shared to the virtual machine so any changes made here will manifest instantly
on your virtual machine
8.) Open a browser on your host machine (the real machine) and browse to http://192.168.56.102 or
whatever your machine's IP was set to in config.yaml
9.) Start developing!

********************************
Debugging
********************************
This system installs XDebug into the virtual dev environment. If you have XDebug setup
on your PHP Storm instance then it is pretty easy do efficient "break point" debugging.
Turn on your debugger in PHP Storm (top right corner), set the debugger cookie in your browser
with the bookmarklets here: https://www.jetbrains.com/phpstorm/marklets/, then
set some breakpoints. PHP Storm will notify you of a new connection and pause on the code as
it executes.

********************************
Grunt and SASS
********************************


!!PHP Storm does this automatically - need to update script and write setup directions here.


OHS uses Grunt and SASS for rapid and efficient CSS from SASS development.

starting here:
http://ryanchristiani.com/getting-started-with-grunt-and-sass/
Other helpful site
http://gruntjs.com/getting-started

The puphpet/files/exec-once/a_install_wp_foundation.sh script will install node.js and NPM to the virtual machine on
first run as such:
1.) Install node.js to the virtual machine with apt-get
2.) Install npm to the virtual machine apt-get
3.) Use npm to install the grunt CLI
    "npm install -g grunt-cli"
4.) Copy the default Gruntfile.js and package.json files from the /puphpet/files directory to the /var/www/html
    directory of the virtual machine
5.) Setup the Grunt modules (execute from the project's html directory)
    "npm install grunt --save-dev"
6.) Install SASS Grunt Module (execute from the project's html directory)
    "npm install grunt-contrib-sass --save-dev"
7.) Install Contrib Watch Grunt Module to keep an eye on changes (execute from the project's html directory)
    "npm install grunt-contrib-watch --save-dev"
8.) Create theme folder based on the WP_Title variable above
2.) Add the style folder to the theme folder
3.) Add the SCSS folder to the theme folder

TODO STUFF:
********************************
Adding DB to GH
********************************
-Write a script that pulls down the DB into a root level file for push to GH

********************************
Second Run and thereafter
********************************
-make the script so that the install WP doesn't run when someone is setting up from GH for the first time.

********************************
Scripts to run on each Vagrant Up
********************************
-Autorun Grunt on Vagrant Up
-Can we uglify?
-What about hint?
-minify?

********************************
Building from GH
********************************
1.) Extract all files that are needed
2.) Exclude files not needed for release (SASS stuff, etc)
3.) Get the DB
