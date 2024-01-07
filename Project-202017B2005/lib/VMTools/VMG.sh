#!/bin/bash
 
source ~/Project-202017B2005/lib/banners

	bannerColor 'Virtual Machine Guest Tools Installation' "cyan" "*"
	
	echo "+------------------------------------------+"
	echo -n "Please Insert Guest Additions CD image from the Virtual Machine menu bar, go to Devices => click on Insert Guest Additions CD image. This helps to mount the Guest Additions ISO file inside your virtual machine. :" 
	echo
	echo "+------------------------------------------+"

	echo -n "Have you inserted the Guest Additions CD image from the Virtual Machine menu bar?"
	read value
	
	
	if [ $value == 'Y']
	then
	{
echo -n "Please Insert Guest Additions CD image from the Virtual Machine menu bar, go to Devices => click on Insert Guest Additions CD image. This helps to mount the Guest Additions ISO file inside your virtual machine. :" 
	echo 
	}
	fi
	
	if [ $value == 'N']
	then
	{
	echo
	#run this as root, unless you enjoy failing.
	#sudo apt update && sudo apt upgrade
	#sudo apt install build-essential dkms linux-headers-$(uname -r)
	#sudo mount /dev/cdrom /media/sachin/cdrom
	cd /media/$USER/VBox_GA*
	#echo -n "Please enter the password"
	./autorun.sh
	}
	fi
