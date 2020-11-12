#!/bin/bash

sudo yum install -y nfs-utils
sudo mkdir -p /scratch
sudo mkdir -p /software
sudo mount -t nfs 192.168.1.1:/scratch /scratch
sudo mount -t nfs 192.168.1.1:/software /software
