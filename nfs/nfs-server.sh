sudo yum install -y nfs-utils
sudo mkdir -p /scratch
sudo mkdir -p /software
sudo chown nobody:nobody /scratch
sudo chown nobody:nobody /software
sudo chmod 777 /scratch
sudo systemctl enable rpcbind
sudo systemctl enable nfs-server
sudo systemctl enable nfs-lock
sudo systemctl enable nfs-idmap
sudo systemctl start rpcbind
sudo systemctl start nfs-server
sudo systemctl start nfs-lock
sudo systemctl start nfs-idmap
echo "/scratch 192.168.1.2(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports
echo "/scratch 192.168.1.3(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports
sudo systemctl restart nfs-server
