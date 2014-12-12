# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  
  # box name.  Any box from vagrant share or a box from a custom URL. 
  config.vm.box = "ubuntu/trusty64"
  
  # box modifications, including memory limits and box name. 
  config.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "2048"]
	 vb.name = "Magento2 Vagrant"
  end

  ## IP to access box
  config.vm.network "private_network", ip: "192.168.33.10"

  # If you want to share an additional folder, (such as a project root). 
  # If you experience slow throughput or performance on the folder share, you 
  # might have to use an OS specific share. 
  # 
  # Default Share:
  # config.vm.synced_folder "../data", "/vagrant_data"
  # 
  # NFS Share, Good for Unix based OS (Mac OSX, Linux): 
  # config.vm.synced_folder ".", "/vagrant", type: "nfs"
  #
  # SMB Share, good for Windows:
  # (If experiencing issues, upgrade PowerShell to V 3.0)
  # config.vm.synced_folder ".", "/vagrant", type: "smb"
  
  ## Bootstrap script to provision box.  All installation methods can go here. 
  config.vm.provision :shell, :path => "bootstrap.sh"
  
  # If you need to forward ports, you can use this command:
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  
  ## Post Up Message.  This is the message that is output to the user once the box has been provisioned.
  config.vm.post_up_message = "Magento2 Vagrant Box ready! Go to http://192.168.33.10/setup/ to finish installation. "
end