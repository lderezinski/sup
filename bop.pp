class directories {

  # create a directory
  file { '/opt/BOP':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
}
file { "/opt/BOP":
  ensure => directory,
  owner => "root",
  group => "root",
  mode => "0644",
  require => Exec["mget-BOP-019"],
}

exec { "mget-BOP-019":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/BOP-019 /opt/BOP/BOP-019",
}

exec { "mget-adminRun":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/adminRun /opt/BOP/adminRun",
}


exec { "mget-checkChronos":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/checkChronos /opt/BOP/checkChronos",
}


exec { "mget-checkHourly":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/checkHourly /opt/BOP/checkHourly",
}


exec { "mget-copy2manta":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/copy2manta /opt/BOP/copy2manta",
}


exec { "mget-echeckHourly":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/echeckHourly /opt/BOP/echeckHourly",
}


exec { "mget-elapseManta":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/elapseManta /opt/BOP/elapseManta",
}


exec { "mget-idhash.sh":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/idhash.sh /opt/BOP/idhash.sh",
}


exec { "mget-jpcRun":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/jpcRun /opt/BOP/jpcRun",
}


exec { "mget-lindaRun":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/lindaRun /opt/BOP/lindaRun",
}


exec { "mget-mantaRun":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/mantaRun /opt/BOP/mantaRun",
}


exec { "mget-mantaenv.sh":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/mantaenv.sh /opt/BOP/mantaenv.sh",
}


exec { "mget-opscheck":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/opscheck /opt/BOP/opscheck",
}


exec { "mget-poseidonRun":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/poseidonRun /opt/BOP/poseidonRun",
}


exec { "mget-sshconfig.txt":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/sshconfig.txt /opt/BOP/sshconfig.txt",
}


exec { "mget-testmain.sh":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/testmain.sh /opt/BOP/testmain.sh",
}


exec { "mget-thothRun":
  command => "/root/sup/mget_if_changed.sh /linda/stor/BOP/thothRun /opt/BOP/thothRun",
}
exec { "install-manta-hk":
  command => "/usr/bin/cd /opt && /opt/local/bin/git clone git@github.com:joyent/manta-hk.git && /usr/bin/cd /opt/manta-hk && npm install",
  cwd => "/opt/BOP",
}



cron { "reapply-bop":
  command => "/opt/local/bin/puppet apply /root/sup/bop.pp",
  user => "root",
  minute => 45,
}


