
OHS WordPress Foundation virtual machine

This package will automatically build a vagrant virtual machine on Ubuntu.
This was built for use with PHP Storm but it should work in other Vagrant
environments.

When Vagrant is finished running you should have a complete virtual machine with
a WordPress DB, WordPress, Grunt, Sass and XDebug all installed and configured.

On second run, if a VM is not available WPFoundation will assume you are now working on an established
project. The build script will have changed so as not to create a new WordPress install but rather
use the existing one.

If a VM is available on second run Vagrant will simply launch the VM and start Grunt so you can begin developing.

********************************
Important things to know
********************************
!!!!!!!!!!!!!!!Make sure to read the instructions below!!!!!!!!!!!!!!!!!!!


********************************
Requirements for host machine
********************************
Oracle Virtual Box
Vagrant
PHP
Ruby

********************************
Recommended
********************************
PHP Storm 8+

********************************
Instructions
********************************
WARNING: Don't Run Vagrant Up until all required steps below are completed.

I. Configure the Virtual Machine

The virtual machine configuration is mostly handled in the config.yaml file
at the root of this package. Set the IP address of the virtual machine on
line 11 of config.yaml. Make sure to set it to a unique IP address that is
unused by other virtual machines. Only change the 4th octet (102).

By default the setting looks as such:

private_network: 192.168.56.102

Again, please make sure that this IP address is unique. It is best to change it from the 102 address

Set the hostname to be unique in case you have multiple Vagrant machines running. Failure to set a unique hostame
may result in failure to successfully run Vagrant

On or near line 6 of config.yaml the default hostname is:
hostname: local.wpfoundation

When vagrant is finished running the inital setup you may view your website
from the host machine at http://192.168.56.102 (or whatever IP address you chose). If you have multiple machines make
sure to assign them different IP addresses!

II. Configuration of the Database, WordPress and Web Server

The configuration is managed by the file puphpet/files/exec-once/a_install_ohs_wp_foundation_I.sh
This file installs the database, wp-cli, wp and various other necessary components. By default the top of the file
looks as such:

DB_NAME="WP_Foundation"             <----- The name that the database for WordPress will have
DB_USER_NAME="WP_User"              <----- The name that the database user will have
DB_PASS="OHSWPFoundationPW"         <----- The password to be assigned to the database user

WP_TITLE="WPFoundation"             <----- The name that the WordPress website will have
WP_USER="admin"                     <----- The name to be given to the administrative user for the WordPress site
WP_USER_PASS="admin"                <----- The password to be assigned to the administrative user
WP_USER_EMAIL="admin@admin.com"     <----- The email address to be assigned to the database user
WP_IP="192.168.56.102"              <----- The IP address of the WordPress site. This should match the IP assigned in step I in config.yaml

Set these variables to values that make sense for you.

III. Getting Started


    1.) Create a new project with PHP Storm (and pull the empty project from Git of you are working for OHS)
    2.) Copy the contents of this package into the root of the project folder
    3.) If Vagrant and VirtualBox are not already installed and configured for PHP Storm, do so now
    4.) Adjust configurations mentioned above
    5.) Run Vagrant Up from the Tools->Vagrant menu
    6.) Go have coffee, it takes a while, typically 10 to 20 minutes
    7.) When finished, the "html" folder will be populated with WordPress files. This folder is
    automatically shared to the virtual machine so any changes made here will manifest instantly
    on your virtual machine
    8.) Open a browser on your host machine (the real machine) and browse to http://192.168.56.102 or
    whatever your machine's IP was set to in config.yaml
    9.) Start developing!

NOTE:
If you are collaborating with other developers they will require a sql database file to clone your WP environment.
This cloning will happen automatically the first time the second user attempts to run Vagrant Up, however a database
file is required. Before every commit it is wise to extract the WordPress database into a SQL file and save it in the
puphpet/files folder. The file name must be "backup_latest.sql". If the file is there then the first time a new developer
starts the project it will automatically push the backup_latest.sql into the virtual machine's local database.

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
PHP Storm has the ability to do file watching and auto compile from SCSS to CSS. However, WPFoundation also auto
installs Grunt with SASS, Watch and some other features. By default Grunt will start every time you launch your
Vagrant virtual machine. Grun watches the directory /var/www/html/wp-content/themes/<Them Name> for any scss files and
will auto generate the css file when it detects changes. To disable Grunt simple edit the file
/puphpet/files/startup-always/initialize.sh and comment out the line "screen -d -m -S GruntWatch grunt".


TODO STUFF:
The stuff below will be added in future releases.
********************************
Adding DB to GH
********************************
-Write a script that pulls down the DB into /puphpet/files automatically for push to GH

********************************
Scripts to run on each Vagrant Up
********************************
-Can we uglify?
-What about hint?
-minify?

********************************
Building from GH
********************************
1.) Extract all files that are needed
2.) Exclude files not needed for release (SASS stuff, etc)
3.) Get the DB



