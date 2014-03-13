# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network "private_network", ip: "192.168.4.20"

  # Change this as your needs
  config.vm.hostname = 'mcgyver.dionochner.com.br'

  config.vm.synced_folder "./files", "/home/vagrant/releases/current"
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

  config.vm.provision :shell,
    inline: "sudo apt-get update -y && sudo apt-get install puppet -y"

  config.vm.provision :shell,
    inline: "sudo usermod -a -G www-data vagrant"

  config.vm.provision :shell,
    inline: "sudo chown -R vagrant:www-data /home/vagrant && sudo chmod -R g+w /home/vagrant && sudo chmod g+s /home/vagrant"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "wordpress_kickstart.pp"

    puppet.module_path = "./modules"
    puppet.options = "--verbose"
  end
end
