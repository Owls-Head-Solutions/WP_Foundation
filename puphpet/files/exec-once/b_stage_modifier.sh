#!/usr/bin/env bash
#this script is responsible for managing if the a_instal_wp_foundation.sh is used for a brand new WP site or
# for setting up an existing site.case

if [ ! -f /vagrant/puphpet/files/exec-once/a_install_ohs_wp_foundation_I.sh ]; then
    cp /vagrant/puphpet/files/exec-once/a_install_ohs_wp_foundation_I.sh /vagrant/puphpet/files/a_install_ohs_wp_foundation_I.sh
    rm /vagrant/puphpet/files/exec-once/a_install_ohs_wp_foundation_I.sh
    cp /vagrant/puphpet/files/exec-once/a_install_ohs_wp_foundation_II.sh /vagrant/puphpet/files/a_install_ohs_wp_foundation_II.sh
fi

