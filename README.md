# Wordpress Kickstart

Basic wordpress kickstarter project that runs locally on Vagrant, are provisioned by puppet and
uses git.

Based on the great markjaquith/WordPress-Skeleton.

## GETTING STARTED

install https://github.com/smdahlen/vagrant-digitalocean
clone this repo
modify vagrantfile as your needs
    vagrant up

if you need to provision a digitalocean droplet, do

    vagrant up --provider=digital_ocean

This command will create a new droplet, setup your SSH key for authentication, create a new user account, and run the provisioners you have configured.


## Assumptions

* Webroot in `/files`
* WordPress as a Git submodule in `/files/wp/`
* Custom content directory in `/files/content/` (cleaner, and also because it can't be in `/wp/`)
* `wp-config.php` in the webroot (because it can't be in `/wp/`)
* All writable directories are symlinked to similarly named locations under `/shared/`.

## Questions & Answers

**Q:** Why the `/shared/` symlink stuff for uploads?
**A:** For local development, create `/shared/` (it is ignored by Git), and have the files live there. For production, have your deploy script (Capistrano is my choice) look for symlinks pointing to `/shared/` and repoint them to some outside-the-repo location (like an NFS shared directory or something). This gives you separation between Git-managed code and uploaded files.
