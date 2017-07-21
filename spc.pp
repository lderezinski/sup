exec { "mget-profile":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/sup/profile.spc /root/.profile",
}

exec { "mget-sdc-config":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/sup/sdc-config.json /opt/local/lib/node_modules/toolbox/node_modules/sdc/etc/config.json",
}

exec { "mget-sup-notify-dc":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/sup/spc.json /opt/local/lib/node_modules/sup-notify/etc/dc.json",
}

exec { "mget-im-notices":
  command => "/root/sup/mget_if_changed.sh /joyentsup/stor/sup/im-notices.json /opt/local/lib/node_modules/im-notices/etc/config.json",
}
