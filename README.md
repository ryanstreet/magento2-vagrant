# Vagrant for Magento2


Vagrant Setup for Magento 2 install.  All prerequisites setup and running. 

Installs all requisites for Magento 2.  Utilizes Ubuntu 14.04. 

You can reference the Magento2 installation guide [here.](http://devdocs.magento.com/guides/v1.0/install-gde/bk-install-guide.html)

## Prerequisites
### Virtualbox
[VirtualBox](https://www.virtualbox.org/) is an open source virtualizer, an application that can run an entire operating system within its own virtual machine. 

1. Download the installer for your laptop operating system using the links below.
    * [VirtualBox for Windows Hosts](http://download.virtualbox.org/virtualbox/4.3.18/VirtualBox-4.3.18-96516-Win.exe)
    * [VirtualBox for OS X hosts](http://download.virtualbox.org/virtualbox/4.3.18/VirtualBox-4.3.18-96516-OSX.dmg)
    * [VirtualBox for Linux hosts](https://www.virtualbox.org/wiki/Linux_Downloads) (requires that you pick your distro)
1. Run the installer, choosing all of the default options.
    * Windows: Grant the installer access every time you receive a security prompt.
    * Mac: Enter your admin password.
    * Linux: Enter your root password if prompted.
1. Reboot your laptop if prompted to do so when installation completes.
1. Close the VirtualBox window if it pops up at the end of the install.

### Vagrant
[Vagrant](https://www.vagrantup.com/) is an open source command line utility for managing reproducible developer environments. 

1. Download the installer for your laptop operating system using the links below.
    * [Vagrant for Windows hosts](https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.5.msi)
    * [Vagrant for OS X hosts](https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.5.dmg)
    * [Vagrant for Linux hosts](https://www.vagrantup.com/downloads.html) (requires that you pick your distro)
1. Run the installer, choosing all defaults.
1. Reboot your laptop if prompted to do so when installation completes.

## Usage
After Vagrant and Virtualbox are setup, run the following commands to install the Dev Box. 

**Clone the Repository**

    git clone https://github.com/ryanstreet/magento2-vagrant.git
**Navigate to the folder**

    cd /path/to/magento2-vagrant/

**(Optional) Add Github Personal Access Token**

Read [this](http://devdocs.magento.com/guides/v1.0/install-gde/trouble/tshoot_rate-limit.html) guide to get a personal access token.  Once you have created the token, open up the `Vagrantfile` and place the token here:

    githubToken = ""
_Note: If you did not enter a personal access token, Composer will not run automatically.  You will have to run it yourself to finish installation._

**Run Vagrant Command**

    vagrant up

**Other Info**

    Database Username: root
    Database Password: (none)
    Database Name: magento
    URL of Instance: http://192.168.33.10/magento2/
    Host File Configuration: 192.168.33.10 www.magento2.dev magento2.dev


## Issue Reporting
Any and all feedback is welcome.  Please let me know of any issues you may find in the bug tracker on github. You can find it [here. ](https://github.com/ryanstreet/magento2-vagrant/issues)
