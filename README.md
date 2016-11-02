To deploy:

1. Provision a base-64 16.3.1 instance owned by admin, with an interface on the admin network.
2. Change ownership of the instance to joyentsup.
3. Reboot and SSH as root.
4. Copy your private key to `/root/.ssh/id_rsa`.
5. Ensure your public key is in the joyentsup account on Triton Cloud.

```
chmod 600 /root/.ssh/id_rsa
echo nameserver 8.8.8.8 >/etc/resolv.conf
pkgin -y in ruby21-puppet
puppet apply <(curl https://raw.githubusercontent.com/andrewh1978/sup-notify/master/sup-notify.pp)
export MANTA_KEY_ID=$(ssh-keygen -E md5 -l -f .ssh/id_rsa | cut -b 10-56)
export MANTA_URL=https://us-east.manta.joyent.com
export MANTA_USER=<Manta user ID>
mget /andrew.hill/stor/sup-notify-profile >/root/.profile
rm -f /root/.ssh/id_rsa
```

Before testing sebastian, it will be necessary to change one line in the config file in order to locate the templates. I leave this as an exercise to the reader, partly because I haven't had a chance to figure out the best way of automating this, short of pulling a new file from Manta. Or maybe a symlink might be the simplest way.
