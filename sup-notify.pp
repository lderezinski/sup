exec { "bash_profile":
  command => "/opt/local/bin/curl https://raw.githubusercontent.com/andrewh1978/sup-notify/master/.bash_profile >/root/.bash_profile",
}

package { "gcc49":
  ensure => installed,
}

package { "gmake":
  ensure => installed,
}

package { "git":
  ensure => installed,
}

package { "net-snmp":
  ensure => installed,
}

exec { "mib-netapp":
  command => "/opt/local/bin/curl 'https://resources.manageengine.com/viewFile.do?fileId=49000007707629&forumGroupId=49000000002007' >/opt/local/share/snmp/mibs/NETAPP-MIB.txt",
  require => Package["net-snmp"],
}

exec { "remove-nodejs":
  command => "/opt/local/bin/pkgin -y rm nodejs",
  unless => "/usr/bin/test ! -f /opt/local/bin/node || /opt/local/bin/node --version | grep -q v0.10.48",
}

package { "nodejs":
  ensure => "0.10.48",
  require => Exec["remove-nodejs"],
  before => [ Exec["install-manta"], Exec["install-sebastian"], Exec["install-toolbox"] ],
}

exec { "known_hosts":
  command => "/usr/bin/ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts",
  unless => "/usr/bin/test -f /root/.ssh/known_hosts",
}

exec { "install-manta":
  command => "/opt/local/bin/npm install -g manta",
  unless  => "/usr/bin/test -f /opt/local/bin/mget",
}

exec { "install-sebastian":
  require => [ Package["gcc49"], Package["gmake"], Package["git"] ],
  command => "/opt/local/bin/npm install -g git+ssh://git@github.com:joyent/node-sebastian.git",
  unless  => "/usr/bin/test -f /opt/local/bin/sebastian",
  environment => "HOME=/root",
}

exec { "install-sebastian-templates":
  require => Exec["known_hosts"],
#  command => "/opt/local/bin/git clone git@github.com:joyent/triton-cloud-notification-templates.git",
  command => "/opt/local/bin/git clone git@github.com:plumtrees/triton-cloud-notification-templates",
  cwd => "/opt/local/lib",
}

exec { "download-toolbox":
  require => Package["git"],
  command => "/opt/local/bin/git clone git@github.com:joyent/support-toolbox.git",
  cwd => "/root",
}

exec { "install-toolbox":
  require => [ Exec["download-toolbox"] ],
  command => "/opt/local/bin/npm install",
  cwd => "/root/support-toolbox",
  environment => "HOME=/root",
}

exec { "link-node":
  require => Exec["download-toolbox"],
  command => "/opt/local/bin/mkdir -p /root/support-toolbox/node_modules/sdc/build/node/bin && /opt/local/bin/ln -s /opt/local/bin/node /root/support-toolbox/node_modules/sdc/build/node/bin/node",
}

file { "toolbox":
  path => "/root/toolbox",
  ensure => "link",
  target => "/root/support-toolbox",
  require => Exec["download-toolbox"],
}
