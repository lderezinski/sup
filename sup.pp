file { "/root/.ssh/config":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0600",
  source => "/root/sup/ssh-config",
}

file { "/root/.bash_profile":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0600",
  source => "/root/sup/.bash_profile",
}

file { "/opt/local/etc/postfix/main.cf":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0600",
  source => "/root/sup/main.cf",
  before => Service["postfix"],
}

file { "/opt/local/lib/node_modules/sup-notify/etc":
  ensure => directory,
  owner => "root",
  group => "root",
  mode => "0644",
  require => Exec["install-sup-notify"],
}

file { "/opt/local/lib/node_modules/im-notices/etc":
  ensure => directory,
  owner => "root",
  group => "root",
  mode => "0644",
  require => Exec["install-im-notices"],
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

exec { "remove-nodejs":
  command => "/opt/local/bin/pkgin -y rm nodejs",
  unless => "/usr/bin/test ! -f /opt/local/bin/node || /opt/local/bin/node --version | grep -q v0.10.48",
}

package { "nodejs":
  ensure => "0.10.48",
  require => Exec["remove-nodejs"],
  before => [ Package["manta"], Exec["install-sup-notify"], Exec["install-toolbox"], Exec["install-im-notices"], Exec["install-new-ufds-users"] ],
}

package { "p5-libwww":
  ensure => installed,
}

package { "p5-JSON":
  ensure => installed,
}

package { "p5-App-cpanminus":
  require => Package["gmake"],
  ensure => installed,
}

package { "manta":
  ensure => present,
  provider => "npm",
}

package { "mosh":
  ensure => present,
}

exec { "install-sup-notify":
  require => [ Package["gcc49"], Package["gmake"] ],
  command => "/root/sup/npm_from_git.sh https://github.com/joyent/sup-notify.git",
}

exec { "install-sup-notify-templates":
  command => "/opt/local/bin/git clone git+ssh://git@github.com/joyent/triton-cloud-notification-templates.git",
  unless  => "/usr/bin/test -d /opt/local/lib/triton-cloud-notification-templates",
  cwd => "/opt/local/lib",
}

exec { "update-sup-notify-templates":
  command => "/opt/local/bin/git pull",
  unless  => "/usr/bin/test ! -d /opt/local/lib/triton-cloud-notification-templates",
  cwd => "/opt/local/lib/triton-cloud-notification-templates",
}

exec { "install-toolbox":
  require => [ Package["gcc49"], Package["gmake"] ],
  command => "/root/sup/npm_from_git.sh https://github.com/joyent/sup-toolbox.git",
  timeout => 600,
}

exec { "install-im-notices":
  require => [ Package["gcc49"], Package["gmake"] ],
  command => "/root/sup/npm_from_git.sh https://github.com/joyent/sup-im-notices.git",
}

cpanm { "JIRA::REST":
  require => Package["p5-App-cpanminus"],
  ensure => installed,
}

exec { "install-new-ufds-users":
  require => [ Package["gcc49"], Package["gmake"] ],
  command => "/root/sup/npm_from_git.sh https://github.com/joyent/sup-new-ufds-users.git",
}

cron { "refresh-from-git":
  command => "cd /root/sup ; /opt/local/bin/git pull",
  user => "root",
  minute => 0,
}

cron { "reapply-sup":
  command => "/opt/local/bin/puppet apply /root/sup/sup.pp",
  user => "root",
  minute => 30,
}
