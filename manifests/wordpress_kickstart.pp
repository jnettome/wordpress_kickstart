group { 'puppet': ensure => present }
Exec { path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/'] }
File { owner => 0, group => 0, mode => 0644 }

class build-essentials-requirement {
  package { "build-essential":
    ensure => "installed"
  }
}

class nginx-requirement {
  include nginx

  package { "python-software-properties":
    ensure => present,
  }

  file { '/etc/nginx/sites-available/default':
    owner  => root,
    group  => root,
    ensure => file,
    mode   => 644,
    source => '/home/vagrant/shared/nginx/default',
    require => Package["nginx"],
  }

  file { "/etc/nginx/sites-enabled/default":
    notify => Service["nginx"],
    ensure => link,
    target => "/etc/nginx/sites-available/default",
    require => Package["nginx"],
  }
}

class { "mysql":
  root_password => 'auto',
}

mysql::grant { 'wordpress':
  mysql_privileges => 'ALL',
  mysql_password => 'wordpress-vagrant',
  mysql_db => 'wordpress',
  mysql_user => 'wordpress',
  mysql_host => 'localhost',
}

class php-setup {
  $php = ["php5-fpm", "php5-cli", "php5-dev", "php5-gd", "php5-curl", "php-apc", "php5-mcrypt", "php5-xdebug", "php5-sqlite", "php5-mysql", "php5-memcache", "php5-intl", "php5-tidy", "php5-imap", "php5-imagick"]

  exec { 'add-apt-repository ppa:ondrej/php5':
    command => '/usr/bin/add-apt-repository ppa:ondrej/php5',
    require => Package["python-software-properties"],
  }

  exec { 'apt-get update for ondrej/php5':
    command => '/usr/bin/apt-get update',
    before => Package[$php],
    require => Exec['add-apt-repository ppa:ondrej/php5'],
  }

  package { $php:
    notify => Service['php5-fpm'],
    ensure => latest,
  }

  package { "apache2.2-bin":
    notify => Service['nginx'],
    ensure => purged,
    require => Package[$php],
  }

  package { "imagemagick":
    ensure => present,
    require => Package[$php],
  }

  package { "libmagickwand-dev":
    ensure => present,
    require => Package["imagemagick"],
  }

  file { '/etc/php5/cli/php.ini':
    owner  => root,
    group  => root,
    ensure => file,
    mode   => 644,
    source => '/home/vagrant/shared/php/cli/php.ini',
    require => Package[$php],
  }

  file { '/etc/php5/fpm/php.ini':
    notify => Service["php5-fpm"],
    owner  => root,
    group  => root,
    ensure => file,
    mode   => 644,
    source => '/home/vagrant/shared/php/fpm/php.ini',
    require => Package[$php],
  }

  file { '/etc/php5/fpm/php-fpm.conf':
    notify => Service["php5-fpm"],
    owner  => root,
    group  => root,
    ensure => file,
    mode   => 644,
    source => '/home/vagrant/shared/php/fpm/php-fpm.conf',
    require => Package[$php],
  }

  file { '/etc/php5/fpm/pool.d/www.conf':
    notify => Service["php5-fpm"],
    owner  => root,
    group  => root,
    ensure => file,
    mode   => 644,
    source => '/home/vagrant/shared/php/fpm/pool.d/www.conf',
    require => Package[$php],
  }

  service { "php5-fpm":
    ensure => running,
    require => Package["php5-fpm"],
  }

}

class { 'apt':
  always_apt_update    => true
}

include build-essentials-requirement
include nginx-requirement
include php-setup

notice "------------------------------------------------------------------------"
notice "|                     Wordpress Kickstart                              |"
notice "------------------------------------------------------------------------"
