#!/usr/bin/env bash

# This script can be used to perform any sort of command line actions to setup your box. 
# This includes installing software, importing databases, enabling new sites, pulling from 
# remote servers, etc. 

# update
echo "########################"
echo "##### UPDATING APT #####"
echo "########################"
apt-get update

# Install Apache
echo "#############################"
echo "##### INSTALLING APACHE #####"
echo "#############################"
apt-get -y install apache2

# Creating folder
echo "#######################################"
echo "##### MAGENTO2 FOLDER PERMISSIONS #####"
echo "#######################################"
chmod 0777 -R /var/www/html/magento

# enable modrewrite
echo "#######################################"
echo "##### ENABLING APACHE MOD-REWRITE #####"
echo "#######################################"
a2enmod rewrite 

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
</VirtualHost>
" > /etc/apache2/sites-available/magento2.conf

echo "ServerName localhost" >> /etc/apache2/apache2.conf 

# Enabling Site
echo "##################################"
echo "##### Enabling Magento2 Site #####"
echo "##################################"
a2ensite magento2.conf

# Setting Locales
echo "###########################"
echo "##### Setting Locales #####"
echo "###########################"
locale-gen en_US en_US.UTF-8 pl_PL pl_PL.UTF-8
dpkg-reconfigure locales

# Install MySQL 5.6
echo "############################"
echo "##### INSTALLING MYSQL #####"
echo "############################"
export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server-5.6 mysql-client-5.6

# Create Database instance
echo "#############################"
echo "##### CREATING DATABASE #####"
echo "#############################"
mysql -u root -e "create database magento;"

# Install PHP 7.0
echo "##########################"
echo "#### INSTALLING PHP 7.0 ##"
echo "##########################"

apt-get -q -y  install python-software-properties
add-apt-repository ppa:ondrej/php
apt-get -q -y  update
apt-get -q -y  purge php5-fpm
apt-get -q -y  install php7.0-cli php7.0-common libapache2-mod-php7.0 php7.0 php7.0-mysql php7.0-fpm php7.0-curl php7.0-gd php7.0-mysql php7.0-bz2 php7.0-dev

echo "################################"
echo "#INSTALLING phpMyAdmin 4.5.3.1 #"
echo "################################"

wget https://files.phpmyadmin.net/phpMyAdmin/4.5.3.1/phpMyAdmin-4.5.3.1-all-languages.zip -P /var/www/html/
apt-get -q -y  install unzip
unzip /var/www/html/phpMyAdmin-4.5.3.1-all-languages.zip -d /var/www/html/
mv /var/www/html/phpMyAdmin-4.5.3.1-all-languages/ /var/www/html/phpmyadmin/

echo "################################"
echo "#### CONFIGURING phpMyAdmin ####"
echo "################################"
cp /var/www/html/phpmyadmin/config.sample.inc.php /var/www/html/phpmyadmin/config.inc.php
sed -i "s/\['AllowNoPassword'\] = false;/\['AllowNoPassword'\] = true;/g" /var/www/html/phpmyadmin/config.inc.php
/etc/init.d/apache2 restart

# PHP extensions
echo "########################"
echo "##### PHP EXTENSIONS ###"
echo "########################"
apt-get -q -y  install php7.0-xml
apt-get -q -y  install php7.0-mcrypt
apt-get -q -y  install php7.0-intl
apt-get -q -y  install php7.0-mbstring
apt-get -q -y  install php7.0-zip
apt-get -q -y  install php7.0-pear
apt-get -q -y  install libcurl3-openssl-dev
pecl install pecl_http
/etc/init.d/apache2 restart

# Set PHP Timezone
echo "########################"
echo "##### PHP TIMEZONE #####"
echo "########################"
echo "date.timezone = America/New_York" >> /etc/php/7.0/cli/php.ini

# Set Pecl php_ini location
echo "##########################"
echo "##### CONFIGURE PECL #####"
echo "##########################"
pear config-set php_ini /etc/php/7.0/apache2/php.ini

# Install Xdebug
echo "##########################"
echo "##### INSTALL XDEBUG #####"
echo "##########################"
pecl install xdebug

# Install Pecl Config variables
echo "############################"
echo "##### CONFIGURE XDEBUG #####"
echo "############################"
echo "xdebug.remote_enable = 1" >> /etc/php/7.0/apache2/php.ini
echo "xdebug.remote_connect_back = 1" >> /etc/php/7.0/apache2/php.ini

# Install Git
echo "##########################"
echo "##### INSTALLING GIT #####"
echo "##########################"
apt-get -y install git

# Composer Installation
echo "###############################"
echo "##### INSTALLING COMPOSER #####"
echo "###############################"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Set Ownership and Permissions
echo "#############################################"
echo "##### SETTING OWNERSHIP AND PERMISSIONS #####"
echo "#############################################"
chown -R www-data /var/www/html/magento2/
find /var/www/html/magento2/ -type d -exec chmod 700 {} \;
find /var/www/html/magento2/ -type f -exec chmod 600 {} \;

# Magento 2 Installation from composer
echo "############################################"
echo "##### INSTALLING COMPOSER DEPENDENDIES #####"
echo "############################################"
 if [ -z "$1" ]
 	then
 		echo "################################################################"
 		echo "##### NO GITHUB API TOKEN.  SKIPPING COMPOSER INSTALLATION #####"
		echo "################################################################"
	else
		composer config -g github-oauth.github.com $1
		cd /var/www/html/magento2/
		composer config repositories.magento composer http://packages.magento.com
		composer require magento/sample-bundle-all:1.0.0
fi


# Restart apache
echo "#############################"
echo "##### RESTARTING APACHE #####"
echo "#############################"
service apache2 restart

# Post Up Message
echo "Magento2 Vagrant Box ready!"
if [ -z "$1" ]
	then
		echo "Final installation instructions:"
		echo "run 'vagrant ssh'"
		echo "run 'cd /var/www/html/magento2/'"
		echo "run 'composer install'"
		echo "When prompted, enter your github API credentials"
		echo "Afterward finish installation."
fi
echo "Go to http://192.168.33.10/magento2/setup/ to finish installation."
echo "If you configured your hosts file, go to http://www.magento2.dev/setup/"

