
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

exec { "remove-nodejs":
  command => "/opt/local/bin/pkgin -y rm nodejs",
  unless => "/usr/bin/test ! -f /opt/local/bin/node || /opt/local/bin/node --version | grep -q v0.10.48",
}

package { "nodejs":
  ensure => "0.10.48",
  require => Exec["remove-nodejs"],
  before => [ Package["manta"], Exec["install-manta-hk"]],
}

exec { "mget-BOP-019":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/BOP-019 /opt/BOP/BOP-019",
}

exec { "mget-adminRun":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/adminRun /opt/BOP/adminRun",
}


exec { "mget-checkChronos":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/checkChronos /opt/BOP/checkChronos",
}


exec { "mget-checkHourly":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/checkHourly /opt/BOP/checkHourly",
}


exec { "mget-copy2manta":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/copy2manta /opt/BOP/copy2manta",
}


exec { "mget-echeckHourly":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/echeckHourly /opt/BOP/echeckHourly",
}


exec { "mget-elapseManta":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/elapseManta /opt/BOP/elapseManta",
}


exec { "mget-idhash.sh":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/idhash.sh /opt/BOP/idhash.sh",
}


exec { "mget-jpcRun":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/jpcRun /opt/BOP/jpcRun",
}


exec { "mget-lindaRun":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/lindaRun /opt/BOP/lindaRun",
}


exec { "mget-mantaRun":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/mantaRun /opt/BOP/mantaRun",
}


exec { "mget-mantaenv.sh":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/mantaenv.sh /opt/BOP/mantaenv.sh",
}


exec { "mget-opscheck":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/opscheck /opt/BOP/opscheck",
}


exec { "mget-poseidonRun":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/poseidonRun /opt/BOP/poseidonRun",
}


exec { "mget-sshconfig.txt":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/sshconfig.txt /opt/BOP/sshconfig.txt",
}


exec { "mget-testmain.sh":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/BOP/testmain.sh /opt/BOP/testmain.sh",
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


