
file { "/opt/BOP":
  ensure => directory,
  owner => "root",
  group => "root",
  mode => "0644",

}

file { "/root/.ssh/config":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0600",
  source => "/root/sup/ssh-config",
}


package { "gcc49":
  ensure => installed,
  before => Package["nodejs"],
}

package { "gmake":
  ensure => installed,
  before => Package["nodejs"],
}

package { "manta":
  ensure => present,
  provider => "npm",
}

package { "bunyan":
  ensure => present,
  provider => "npm",
}


exec { "remove-nodejs":
  command => "/opt/local/bin/pkgin -y rm nodejs",
  unless => "/usr/bin/test ! -f /opt/local/bin/node || /opt/local/bin/node --version | grep -q v0.10.48",
}

package { "nodejs":
  ensure => "0.10.48",
  require => Exec["remove-nodejs"],
  before => [ Package["manta"], Exec["install-manta-hk"]],
}

file { "//opt/BOP/BOP-019":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-BOP-019"],
}

exec { "mget-BOP-019":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/BOP-019 /opt/BOP/BOP-019",
}

file { "//opt/BOP/adminRun":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-adminRun"],
}

exec { "mget-adminRun":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/adminRun /opt/BOP/adminRun",
}
file { "//opt/BOP/checkChronos":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-checkChronos"],
}


exec { "mget-checkChronos":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/checkChronos /opt/BOP/checkChronos",
}

file { "//opt/BOP/checkHourly":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-checkHourly"],
}

exec { "mget-checkHourly":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/checkHourly /opt/BOP/checkHourly",
}

file { "//opt/BOP/copy2manta":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-copy2manta"],
}

exec { "mget-copy2manta":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/copy2manta /opt/BOP/copy2manta",
}

file { "//opt/BOP/echeckHourly":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-echeckHourly"],
}

exec { "mget-echeckHourly":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/echeckHourly /opt/BOP/echeckHourly",
}
file { "//opt/BOP/elapseManta":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-elapseManta"],
}


exec { "mget-elapseManta":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/elapseManta /opt/BOP/elapseManta",
}
file { "//opt/BOP/idhash.sh":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-idhash.sh"],
}


exec { "mget-idhash.sh":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/idhash.sh /opt/BOP/idhash.sh",
}
file { "//opt/BOP/jpcRun":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-jpcRun"],
}


exec { "mget-jpcRun":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/jpcRun /opt/BOP/jpcRun",
}

file { "//opt/BOP/lindaRun":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-lindaRun"],
}

exec { "mget-lindaRun":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/lindaRun /opt/BOP/lindaRun",
}
file { "//opt/BOP/mantaRun":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-mantaRun"],
}


exec { "mget-mantaRun":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/mantaRun /opt/BOP/mantaRun",
}
file { "//opt/BOP/mantaenv.sh":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-mantaenv.sh"],
}


exec { "mget-mantaenv.sh":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/mantaenv.sh /opt/BOP/mantaenv.sh",
}

file { "//opt/BOP/opscheck":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-opscheck"],
}

exec { "mget-opscheck":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/opscheck /opt/BOP/opscheck",
}
file { "//opt/BOP/poseidonRun":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-poseidonRun"],
}


exec { "mget-poseidonRun":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/poseidonRun /opt/BOP/poseidonRun",
}


exec { "mget-sshconfig.txt":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/sshconfig.txt /opt/BOP/sshconfig.txt",
}

file { "//opt/BOP/testmain.sh":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-testmain.sh"],
}

exec { "mget-testmain.sh":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/testmain.sh /opt/BOP/testmain.sh",
}

file { "//opt/BOP/thothRun":
  ensure => file,
  owner => "root",
  group => "root",
  mode => "0755",
  before => Exec["mget-thothRun"],
}

exec { "mget-thothRun":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/thothRun /opt/BOP/thothRun",
}
exec { "install-manta-hk":
  require => [ Package["gcc49"], Package["gmake"] ],
  command => "/root/sup/git-clone-pull.sh git@github.com:joyent/manta-hk.git",
}



cron { "reapply-bop":
  command => "/opt/local/bin/puppet apply /root/sup/bop.pp",
  user => "root",
  minute => 45,
}


