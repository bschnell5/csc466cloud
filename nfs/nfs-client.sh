#!/bin/bash

sudo yum install -y nfs-utils

for dir in home scratch software; do
  mkdir -p /$dir
  while [ ! -d /scratch/flag ]; do
    sudo mount -t nfs 192.168.1.1:/$dir /$dir || true
    sleep 60
  done
done

for dir in home scratch software; do
  echo '192.168.1.1:$dir /$dir nfs defaults 0 0' | sudo tee -a /etc/fstab
done

for i in $(ls -l /users | grep rwx | cut -d' ' -f3); do
  USER_GROUP=`id -gn ${i}`
  sudo usermod -d /home/$i $i --shell /bin/bash
  sudo chown $i:$USER_GROUP /home/$i
done
