#!/bin/bash

sudo yum install -y nfs-utils

for dir in home scratch software; do
  mkdir -p /$dir
  chown nobody:nobody /$dir
  sudo chmod 755 /$dir
done

mkdir /scratch/flag

while IFS= read -r line; do
  USER_GROUP=`id -gn ${i}`
  sudo usermod -m -d /home/$i $i
  sudo chown $i:$USER_GROUP /home/$i
done < <( ls -l /users | grep rwx | cut -d' ' -f3 )


sudo systemctl enable rpcbind
sudo systemctl enable nfs-server
sudo systemctl enable nfs-lock
sudo systemctl enable nfs-idmap
sudo systemctl start rpcbind
sudo systemctl start nfs-server
sudo systemctl start nfs-lock
sudo systemctl start nfs-idmap

for dir in home scratch software; do
  echo "$dir 192.168.1.2(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports
  echo "$dir 192.168.1.3(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports
done
sudo systemctl restart nfs-server
