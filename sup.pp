exec { "bash_profile":
  command => "/opt/local/bin/curl https://raw.githubusercontent.com/andrewh1978/sup/master/.bash_profile >/root/.bash_profile",
}

exec { "/opt/local/etc/postfix/main.cf":
  command => "/opt/local/bin/curl https://raw.githubusercontent.com/andrewh1978/sup/master/main.cf >/opt/local/etc/postfix/main.cf",
  before => Service["postfix"],
}

service { "postfix":
  ensure => running,
}

package { "gcc49":
  ensure => installed,
  before => Package["nodejs"],
}

package { "gmake":
  ensure => installed,
  before => Package["nodejs"],
}

package { "git":
  ensure => installed,
}

exec { "remove-nodejs":
  command => "/opt/local/bin/pkgin -y rm nodejs",
  unless => "/usr/bin/test ! -f /opt/local/bin/node || /opt/local/bin/node --version | grep -q v0.10.48",
}

package { "nodejs":
  ensure => "0.10.48",
  require => Exec["remove-nodejs"],
  before => [ Package["manta"], Package["sup-notify"], Package["toolbox"], Package["im-notices"] ],
}

package { "p5-libwww":
  ensure => installed,
}

package { "p5-JSON":
  ensure => installed,
}

package { "manta":
  ensure => present,
  provider => "npm",
}

package { "sup-notify":
  ensure => present,
  provider => "npm",
  require => [ Package["gcc49"], Package["gmake"], Package["git"] ],
  source => "git+ssh://git@github.com/joyent/sup-notify.git",
}

exec { "install-sup-notify-templates":
  command => "/opt/local/bin/git clone git@github.com:joyent/triton-cloud-notification-templates.git",
  unless  => "/usr/bin/test -d /opt/local/lib/triton-cloud-notification-templates",
  cwd => "/opt/local/lib",
}

exec { "update-sup-notify-templates":
  command => "/opt/local/bin/git pull",
  unless  => "/usr/bin/test ! -d /opt/local/lib/triton-cloud-notification-templates",
  cwd => "/opt/local/lib/triton-cloud-notification-templates",
}

package { "toolbox":
  ensure => latest,
  provider => "npm",
  require => [ Package["gcc49"], Package["gmake"], Package["git"] ],
  source => "git+ssh://git@github.com/joyent/sup-toolbox.git",
}

package { "im-notices":
  ensure => present,
  provider => "npm",
  require => [ Package["gcc49"], Package["gmake"], Package["git"] ],
  source => "git+ssh://git@github.com/joyent/sup-im-notices.git",
}

exec { "install-rest-client":
  require => Package["gmake"],
  command => "/opt/local/bin/curl http://www.cpan.org/authors/id/K/KK/KKANE/REST-Client-273.tar.gz | /opt/local/bin/tar xzf - && cd REST-Client-273 && /opt/local/bin/perl Makefile.PL && /opt/local/bin/make install",
  cwd => "/usr/local/src",
}

exec { "install-jira-rest":
  require => Exec["install-rest-client"],
  command => "/opt/local/bin/curl http://www.cpan.org/authors/id/G/GN/GNUSTAVO/JIRA-REST-0.017.tar.gz | /opt/local/bin/tar xzf - && cd JIRA-REST-0.017 && /opt/local/bin/perl Makefile.PL && /opt/local/bin/make install",
  cwd => "/usr/local/src",
}

package { "new-ufds-users":
  ensure => present,
  provider => "npm",
  require => [ Package["gcc49"], Package["gmake"], Package["git"] ],
  source => "git+ssh://git@github.com:joyent/sup-new-ufds-users.git",
}

