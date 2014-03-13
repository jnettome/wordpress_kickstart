# Wordpress Kickstart

Basic wordpress kickstarter project that runs locally on Vagrant, production on DigitalOcean, are provisioned by puppet and uses git.

Based on [markjaquith/WordPress-Skeleton](http://github.com/markjaquith/WordPress-Skeleton), [MikeRogers0/vagrant-nginx-wordpress-puppet](http://github.com/MikeRogers0/vagrant-nginx-wordpress-puppet) and this [excellent post](http://blog.publysher.nl/2013/07/infra-as-repo-using-vagrant-and-salt.html).

## Assumptions

  * Your webroot is `/files`
  * All writable directories are symlinked to similarly named locations under `/shared/`.
  * Your production stack is hosted on DigitalOcean

## Getting Started

Install [vagrant-digitalocean](https://github.com/smdahlen/vagrant-digitalocean).

Install [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater)

Clone this repository like `git clone git@github.com:jnettome/wordpress_kickstart.git my-wordpress-project`

Configure your `Vagrantfile` as your needs.

__In order to use with DigitalOcean__ you need to change your DigitalOcean's API credentials in `Vagrantfile`.

If you're working on development

    cd my-wordpress-project
    vagrant up

Or if you're working on production deployment and provisioning

    cd my-wordpress-project
    vagrant up --provider=digital_ocean

This command will create a new droplet, setup your SSH key for authentication, create a new user account, and run the provisioners configured.

__When you are switching from production to development__ or the opposite, remove `.vagrant/` from your project's root folder [(info)](http://blog.publysher.nl/2013/07/infra-as-repo-using-vagrant-and-salt.html).


## Working with

Access your wordpress on [http://192.168.4.20](http://192.168.4.20) or pointing to your hostname from Vagrantfile if you're using vagrant-hostsupdater.

Default mysql credentials:

    hostname: localhost
    database: wordpress
    username: wordpress
    password: wordpress-vagrant


## Roadmap

* Vagrant hosts plugin
* Better production provisioning (secure)
* Configure deploy method (git or capistrano)
