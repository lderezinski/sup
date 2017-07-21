It is not possible to provision an instance on a network that a user does not have permission to use. However, it is possible to change the ownership of an instance to any user. Since we need an interface on the admin network, we need to provision it to be owned by the admin user, then moved to joyentsup. We also need to copy the private SSH key temporarily in order to access some files on Manta that contain information that cannot live on a public repo. You can safely ignore the dtrace errors when you run mget, so long as the file is retrieved and generated.

To deploy:

1. Provision a base-64 17.1.0 instance owned by admin, with an interface on the admin network.
2. Change ownership of the instance to joyentsup.
3. Reboot and SSH as root.
4. Copy your private key to `/root/.ssh/id_rsa`.
5. Ensure your public key is in the joyentsup account on Triton Cloud.
6. Run one of `export DC=jpc` or `export DC=spc`.

```
chmod 600 /root/.ssh/id_rsa
echo nameserver 8.8.8.8 >/etc/resolv.conf
pkgin -y in ruby21-puppet git
ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts
git clone git@github.com:andrewh1978/sup.git
puppet module install puppet-nodejs --version 3.0.0
puppet module install jamesmcdonald-cpanm --version 0.9.3
puppet apply /root/sup/sup.pp
puppet apply /root/sup/$DC.pp
```
