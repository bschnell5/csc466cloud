#!/bin/bash

sudo yum install -y nfs-utils

for dir in scratch software home; do
  mkdir -p /$dir
  while [ ! -d /$dir/flag ]; do
    sudo mount -t nfs 192.168.1.1:/$dir /$dir || true
    sleep 60
  done
done

for dir in scratch software home; do
  echo '192.168.1.1:$dir /$dir nfs defaults 0 0' | sudo tee -a /etc/fstab
done

