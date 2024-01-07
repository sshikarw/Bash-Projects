#!/bin/bash

#utilising Netplan to set up a static IP address on the terminal.

sudo apt install net-tools 

echo "+------------------------------------------+"
echo "Copy and paste the configuration below to set up a static IP. Take note of the YAML file's spacing."
echo "+------------------------------------------+"

cat ~/Project-202017B2005/lib/static_ip_template.txt

sleep 10
<<Configuration
#Default configuration
# Let NetworkManager manage all devices on this system
network:
  version: 2
  renderer: NetworkManager

#Copy and paste the configuration below to set up a static IP. Take note of the YAML file's spacing.

network:
  version: 2
  renderer: NetworkManager
  ethernets:
     enp0s3:
       dhcp4: no
       addresses:
         - 192.168.1.125/24
       routes:
         - to: default
           via: 192.168.1.1
       nameservers:
          addresses: [8.8.8.8, 8.8.4.4]


#From network to addresses and change the IP as per your need          
Configuration

#cat /usr/share/doc/netplan/examples/static.yaml
#manually copy and pasting the above commands into the /etc/netplan/01-network-manager-all.yaml and Save the file 
#sudo netplan apply


#Copying default "01-network-manager-all.yaml" from /etc/netplan to your Project defaults folder for backup
sudo mv  /etc/netplan/01-network-manager-all.yaml ~/Project-202017B2005/defaults   


#Static IP address
#echo "+------------------------------------------+"
#echo "Please edit the addresses and gateway4 as per you need in the file. "
#echo "+------------------------------------------+"

sleep 1

sudo nano /etc/netplan/01-network-manager-all.yaml 
#sudo nano ~/Project-202017B2005/lib/01-network-manager-all.yaml 


#Replacing "01-network-manager-all.yaml" from Project lib folder to /etc/netplan for configuartion		
#sed -i 's/[192.168.2.10/24]/$static_IP_address/g' ~/Project-202017B2005/lib/01-network-manager-all.yaml

#sudo mv  ~/Project-202017B2005/lib/01-network-manager-all.yaml /etc/netplan  

sudo netplan apply

echo "+------------------------------------------+"
echo  "Current Static IP: "  
echo 
ifconfig
