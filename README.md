It is not possible to provision an instance on a network that a user does not have permission to use. However, it is possible to change the ownership of an instance to any user. Since we need an interface on the admin network, we need to provision it to be owned by the admin user, then moved to joyentsup. We also need to sign a Manta object containing the sup private SSH key. This key is used to fetch private Github repos and configs from Manta.

To deploy:

1. Provision a base-64 17.2.0 instance owned by admin (9dce1460-0c4c-4417-ab8b-25ca478c5a78), with an interface on the admin network, using the g4-highcpu-8G package.
2. Change ownership of the instance to joyentsup.
3. Ensure your public key is in the joyentsup account on Triton Cloud.
4. Reboot and SSH as root.
5. Run `sm-set-hostname <hostname>` and reboot.
6. Run `echo nameserver 8.8.8.8 >/etc/resolv.conf` on the new instance.
7. Run `./get_sign /joyentsup/stor/sup/sup_manta.key 1H` on your laptop.
8. Paste from the clipboard into the new instance.

```
mv /root/sup_manta.key /root/.ssh/sup_manta.key
chmod 600 /root/.ssh/sup_manta.key
ssh-keygen -y -f /root/.ssh/sup_manta.key >/root/.ssh/sup_manta.key.pub
pkgin -y in ruby24-puppet git
ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts
git clone https://github.com/andrewh1978/sup.git
puppet module install puppet-nodejs --version 3.0.0
puppet module install jamesmcdonald-cpanm --version 0.9.3
puppet apply /root/sup/sup.pp
puppet apply /root/sup/bop.pp
```

Run one of:

```
puppet apply /root/sup/spc.pp
```

or

```
puppet apply /root/sup/jpc.pp
```
