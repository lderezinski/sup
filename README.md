It is not possible to provision an instance on a network that a user does not have permission to use. However, it is possible to change the ownership of an instance to any user. Since we need an interface on the admin network, we need to provision it to be owned by the admin user, then moved to joyentsup. We also need to use a personal private SSH key to fetch the sup private SSH key from Manta. This key is used to fetch private Github repos and configs from Manta. Dtrace errors when you run mget can safely be ignored, so long as the file is retrieved and generated.

To deploy:

1. Provision a base-64 17.2.0 instance owned by admin, with an interface on the admin network.
2. Change ownership of the instance to joyentsup.
3. Reboot and SSH as root.
4. Copy your private key to `/root/.ssh/id_rsa`.
5. Ensure your public key is in the joyentsup account on Triton Cloud.

```
chmod 600 /root/.ssh/id_rsa
echo nameserver 8.8.8.8 >/etc/resolv.conf
pkgin -y in ruby24-puppet git
ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts
git clone https://github.com/andrewh1978/sup.git
puppet module install puppet-nodejs --version 3.0.0
puppet module install jamesmcdonald-cpanm --version 0.9.3
puppet apply /root/sup/sup.pp
mget --account=<Manta user ID> --url=https://us-east.manta.joyent.com --keyId=$(ssh-keygen -E md5 -l -f /root/.ssh/id_rsa | cut -b 10-56) /joyentsup/stor/sup/sup_manta.key >/root/.ssh/sup_manta.key
rm -f /root/.ssh/id_rsa
chmod 600 /root/.ssh/sup_manta.key
ssh-keygen -y -f /root/.ssh/sup_manta.key >/root/.ssh/sup_manta.key.pub
```

Run one of:

```
puppet apply /root/sup/spc.pp
```

or

```
puppet apply /root/sup/jpc.pp
```
