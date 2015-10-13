class dokuwiki {
  # example class to install dokuwiki
  # ** highly ** simplified

  # Dokuwiki source
  $dokuwiki_source = '/root/dokuwiki-stable.tgz'
  $dokuwiki_home = '/var/www/html/dokuwiki'
  
  # Apache
  class {'dokuwiki::apache':
    dokuwiki_home => $dokuwiki_home
  }

  file { $dokuwiki_home:
    ensure => 'directory',
    mode   => '0755',
    owner  => 'apache',
    group  => 'apache',
    require => Package['httpd']
  }

  exec { 'extract dokuwiki':
    command => "tar xf ${dokuwiki_source} --strip 1",
    cwd     => $dokuwiki_home,
    creates => "${dokuwiki_home}/doku.php",
    path    => '/bin:/usr/bin',
    require => File[$dokuwiki_home],
  }
  file { "${dokuwiki_home}/install.php":
    ensure  => 'absent',
    require => Exec['extract dokuwiki'],
  }
  # data owned by apache:apache
  file { "${dokuwiki_home}/data":
    ensure  => 'directory',
    owner   => 'apache',
    group   => 'apache',
    recurse => true,
    require => Exec['extract dokuwiki'],
  }
    
  # Dokuwiki configuration
  class { 'dokuwiki::config':
    dokuwiki_home => $dokuwiki_home
  }

  # Dokuwiki content
  class { 'dokuwiki::content':
    dokuwiki_home => $dokuwiki_home
  }
}
