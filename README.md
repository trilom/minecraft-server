# minecraft-server

# using this cookbook
## deploy instructions on source machine
### install the policy
```bash
chef install policies/vanilla.rb
```

### use chef to export, and scp off the compiled cookbook
then you can use chef export to export the whole cookbook and policy (for dependency resolution), configured and ready to drop onto a server
```bash
#export policy to the dirctory above current directory, ran from within the cookbook 'minecraft-server'
chef export policies/minecraft-server.rb -a ../
#send it off
scp -r ../minecraft-server-SOME_LONG_ASS_HASH_WILL_BE_HERE_AFTER_YOU_BUILD_IT.tgz bryan@172.16.2.118:/home/bryan/.
```

## deploy instructions on target

### install chef client on target
```bash
curl -L https://omnitruck.chef.io/install.sh | sudo bash
#make sure it made it on there
chef-client --version
```

### run chef-client local on target
then run chef zero on the target after unpacking the tar
```bash
#build them a home
mkdir -p ~/cookbooks/minecraft-server
#unpack that slut
tar -xvf minecraft-server-SOME_LONG_ASS_HASH_WILL_BE_HERE_AFTER_YOU_BUILD_IT.tgz -C cookbooks/minecraft-server
#get inside
cd cookbooks/minecraft-server
#do your thing 🤙
#you need root
sudo chef-client -z
```

### validate expected results
minecraft should be running
