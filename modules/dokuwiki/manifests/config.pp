class dokuwiki::config 
(
  $dokuwiki_home,
  $dokuwiki_name = 'LISA 2015',

) {
  File { 
    owner   => 'apache',
    group   => 'apache',
    mode    => '0644',
    require => File[$dokuwiki_home]
  }
  
  file { "${dokuwiki_home}/conf/local.php":
    content => template('dokuwiki/local.php.epp'),
  } 
  file { "${dokuwiki_home}/conf/plugins.local.php":
    content => "<?php\n\$plugins['authad']    = 0;\n\$plugins['authldap']  = 0;\n\$plugins['authmysql'] = 0;\n\$plugins['authpgsql'] = 0;\n?>\n",
  } 

  file { "${dokuwiki_home}/conf/users.auth.php":
    source => 'puppet:///modules/dokuwiki/users.auth.php',
  } 

  file { "${dokuwiki_home}/conf/acl.auth.php":
    content => @("ACLAUTH"/n)
      *  @ALL  1
      *  @user 8
      | ACLAUTH
  } 
}
