# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network "private_network", ip: "192.168.4.20"

  config.vm.synced_folder "./files", "/var/www"
  config.vm.synced_folder "./shared", "/home/vagrant/shared"

  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box_url = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'

    provider.client_id = 'YOUR_DIGITALOCEAN_CLIENT_ID'
    provider.api_key = 'YOUR_DIGITALOCEAN_API_KEY'

    provider.image = 'Ubuntu 12.04.3 x64'
    provider.region = 'New York 2'
    provider.size = '512MB'
  end

  config.vm.provision :shell, :inline =>
    "if [[ ! -f /apt-get-run ]]; then sudo apt-get update && sudo touch /apt-get-run; fi"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "wordpress_kickstart.pp"

    puppet.module_path = "./modules"
    puppet.options = "--verbose"
  end
end
