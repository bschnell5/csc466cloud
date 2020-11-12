#!/bin/bash

sudo yum install -y nfs-utils

for dir in home scratch software; do
  mkdir -p /$dir
  while [ ! -d /home/flagdir ]; do
    sudo mount 192.168.1.1:/software /software || true
    sleep 60
  done
done

sudo mkdir -p /scratch
sudo mkdir -p /software
sudo mount -t nfs 192.168.1.1:/scratch /scratch
sudo mount -t nfs 192.168.1.1:/software /software
