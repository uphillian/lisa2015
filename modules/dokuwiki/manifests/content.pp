class dokuwiki::content 
(
  $dokuwiki_home
) {
  File { 
    owner   => 'apache',
    group   => 'apache',
    mode    => '0644',
    require => Exec['extract dokuwiki'],
  }
  file {'start.txt':
    path   => "${dokuwiki_home}/data/pages/start.txt",
    source => 'puppet:///modules/dokuwiki/start.txt',
  }
  file {'puppet':
    ensure => 'directory',
    path   => "${dokuwiki_home}/data/pages/puppet",
    mode   => '0755',
  }
  exec {'content-types':
    command => "puppet doc -r type > ${dokuwiki_home}/data/pages/puppet/type.txt",
    path    => '/opt/puppetlabs/bin:/bin:/usr/bin',
    creates => "${dokuwiki_home}/data/pages/puppet/type.txt",
  }
  exec {'content-functions':
    command => "puppet doc -r function > ${dokuwiki_home}/data/pages/puppet/function.txt",
    path    => '/opt/puppetlabs/bin:/bin:/usr/bin',
    creates => "${dokuwiki_home}/data/pages/puppet/function.txt",
  }
}
