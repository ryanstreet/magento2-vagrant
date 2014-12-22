#!/usr/bin/env bash

# This script can be used to perform any sort of command line actions to setup your box. 
# This includes installing software, importing databases, enabling new sites, pulling from 
# remote servers, etc. 

# update
echo "########################"
echo "##### UPDATING APT #####"
echo "########################"
sudo apt-get update

# Install Apache
echo "#############################"
echo "##### INSTALLING APACHE #####"
echo "#############################"
sudo apt-get -y install apache2

# enable modrewrite
echo "#######################################"
echo "##### ENABLING APACHE MOD-REWRITE #####"
echo "#######################################"
sudo a2enmod rewrite

# append AllowOverride to Apache Config File
echo "#######################################"
echo "##### CREATING APACHE CONFIG FILE #####"
echo "#######################################"
echo "
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/magento2
		ServerName magento2.dev
		ServerAlias www.magento2.dev
		
		<Directory '/var/www/html/magento2'>
			Options Indexes FollowSymLinks MultiViews
			AllowOverride All
			Order allow,deny
			allow from all
		</Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
" > /etc/apache2/sites-available/magento2.conf

echo "ServerName localhost" >> /etc/apache2/apache2.conf 

# Enabling Site
echo "##################################"
echo "##### Enabling Magento2 Site #####"
echo "##################################"
sudo a2ensite magento2.conf

# Install MySQL 5.6
echo "############################"
echo "##### INSTALLING MYSQL #####"
echo "############################"
export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server-5.6 mysql-client-5.6

# Create Database instance
echo "creating database instance"
mysql -u root -e "create database magento2;"

# Install PHP 5.5
echo "installing PHP 5.5.x"
apt-get -y install php5

# Install Required PHP extensions
echo "installing PHP extensions"
apt-get -y install php5-mhash php5-mcrypt php5-curl php5-cli php5-mysql php5-gd php5-intl php5-common

# Mcrypt issue
echo "php mcrypt patch"
# Set PHP Timezone
echo "setting php timezone"
# Set PHP Memory Limit
echo "setting php memory limit"

# Install Composer
echo "installing composer"
curl -s http://getcomposer.org/install | php
mv composer.phar /usr/local/bin/composer

# Install Git
echo "installing Git"
# Clone Magento2 Repository
echo "cloning Magento2 repository"
# Set application ownership
echo "chmod priviledges"
# Set Application Permissions
echo "setting file and folder permissions"
# Composer Installation
echo "installing from composer"

# Restart apache
echo "restarting Apache"
sudo service apache2 restart

