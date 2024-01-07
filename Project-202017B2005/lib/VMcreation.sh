#!/bin/bash

#Change ~ with the your own project directory
#Importing Libraray file 
source ~/Project-202017B2005/lib/banners


bannerColor 'Virtual Machine Creation' "cyan" "*"
echo -n "Enter Virtual Machine name : "
read vmname;

########################
<<revisit
echo -n "Enter Virtual Machine RAM Size [GB] : "
read ram;

echo -n "Enter Virtual Machine Hard Disk Size [GB] : "
read hdd;


memory= expr $ram \* 1024
#vmemory= expr $memory / 8 --Division

vmhdd= expr $hdd \* 1024
revisit
########################

# Download ubuntu.iso
if [ ! -f ./ubuntu.iso ]; then
    wget http://ubuntu-releases.mirror.net.in/ubuntu/releases/22.04/ubuntu-22.04.1-desktop-amd64.iso -O  ubuntu.iso
    
fi

#Create VM
VBoxManage createvm --name $vmname --ostype "Ubuntu_64" --register --basefolder `pwd`

#Set memory and network
VBoxManage modifyvm $vmname --ioapic on

#VBoxManage modifyvm $vmname --memory $memory --vram 128
VBoxManage modifyvm $vmname --memory 1024 --vram 128

VBoxManage modifyvm $vmname --nic1 nat

#Create Disk and connect Ubuntu Iso
#VBoxManage createhd --filename `pwd`/$vmname/$vmname_DISK.vdi --size $vmhdd --format VDI
VBoxManage createhd --filename `pwd`/$vmname/$vmname_DISK.vdi --size 80000 --format VDI

VBoxManage storagectl $vmname --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach $vmname --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium  `pwd`/$vmname/$vmname_DISK.vdi
VBoxManage storagectl $vmname --name "IDE Controller" --add ide --controller PIIX4
VBoxManage storageattach $vmname --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium `pwd`/ubuntu.iso
VBoxManage modifyvm $vmname --boot1 dvd --boot2 disk --boot3 none --boot4 none

#Enable RDP
#VBoxManage modifyvm $vmname --vrde on
#VBoxManage modifyvm $vmname --vrdemulticon on --vrdeport 10001

#Start the VM
#VBoxHeadless --startvm $vmname
VBoxManage startvm $vmname --type gui
