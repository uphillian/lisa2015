class dokuwiki::apache 
(
  $dokuwiki_home
) {
  file {'/etc/httpd/conf.d/doku.conf':
    owner   => 'apache',
    group   => 'apache',
    mode    => '0644',
    require => Package['httpd'],
    content => @("EOF"/n)
      Listen 8080
      <VirtualHost *:8080>
        DocumentRoot $dokuwiki_home
        <Directory $dokuwiki_home>
          AllowOverride all
        </Directory>
      </VirtualHost>
      | EOF
  }
  package { 'httpd':
    ensure => 'installed',
  }
  service { 'httpd':
    ensure => 'running',
    require => Package['httpd'],
  }
  #PHP
  package { 'php': 
    ensure => 'installed',
    notify => Service['httpd'],
  }
}
