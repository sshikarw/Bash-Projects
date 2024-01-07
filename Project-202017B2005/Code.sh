#!/bin/bash
####################################################################
# Sachin Shikarwar (202017B2005 {at} wilp.bits-pilani.ac.in) - Nov 2022
####################################################################
#Simple menu driven shell script for Debian based Linux OS.
#
#Change ~ with the your own project directory
#Importing Libraray file 
#source ~/Project-202017B2005/lib/filename


### Text formatting ###
#echo -e "${BOLD}bold text.${CLEAR} normal text."

CLEAR="\e[0m"

# Text settings.
BOLD="\e[1m"
UNDERLINE="\e[4m"

# Text color.
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"

# Text color with bold font.
RED_BOLD="\e[1;31m"
GREEN_BOLD="\e[1;32m"
YELLOW_BOLD="\e[1;33m"
BLUE_BOLD="\e[1;34m"
MAGENTA_BOLD="\e[1;35m"
CYAN_BOLD="\e[1;36m"

# Background color.
RED_BG="\e[41m"
GREEN_BG="\e[42m"
YELLOW_BG="\e[43m"
BLUE_BG="\e[44m"
MAGENTA_BG="\e[45m"
CYAN_BG="\e[46m"

# Background color with bold font.
RED_BG_BOLD="\e[1;41m"
GREEN_BG_BOLD="\e[1;42m"
YELLOW_BG_BOLD="\e[1;43m"
BLUE_BG_BOLD="\e[1;44m"
MAGENTA_BG_BOLD="\e[1;45m"
CYAN_BG_BOLD="\e[1;46m"

### End of text formatting ###


# Purpose - Show a menu on the screen
function show_menu()
{
	date 
	echo  && echo -e "${GREEN_BOLD}Main Menu${CLEAR}"
	echo "1. Newly Installed Linux System?"
	echo "2. Basic Application Installation"
	echo "3. On Demand Application Installation"
	echo "4. On Demand Application UnInstallation"
	echo "5. On Demand Backup"
	echo "6. User Management"
	echo "7. VM Creation"
	echo "8. Virtual Machine Guest Tools Installation"
	echo "9. File Encryption"
	echo "10.File Decryption"
	echo "11.Firewall Configuration"
	echo "12.Task Automation with Cron"
	echo "13.Exit"
}


# Purpose - Perform Update, Upgrade and Autoremoval 
function os_upgrade()
{
	#System Update, Upgrade and Autoremoval
	echo -e "${BLUE_BOLD}System Update, Upgrade and Autoremoval.${CLEAR}"
	
	echo "+------------------------------------------+"
	
	echo -e "${MAGENTA_BG}Checking for available updates:${CLEAR}"
	sudo apt update;
	
	echo "+------------------------------------------+"
	
	echo "+------------------------------------------+"
	
	echo -e "${YELLOW_BG}Performing upgrade:${CLEAR}"
	sudo apt upgrade -y;
	
	echo "+------------------------------------------+"

	echo "+------------------------------------------+"
	
	echo -e "${GREEN_BG}Performing autoremoval:${CLEAR}"
	sudo apt autoremove -y;
	
	echo "+------------------------------------------+"

	echo "+------------------------------------------+"
	
	echo -e "${GREEN_BG_BOLD}Performing autoclean:${CLEAR}"
	sudo apt autoclean;
	
	echo "+------------------------------------------+"
	
	echo "+------------------------------------------+"
				
	#echo -e "${BLUE_BG_BOLD}System is Ready to use!!${CLEAR}"
	zenity --info --title="Installation completed" --text="System is Ready to use!!" --no-wrap
	
	echo "+------------------------------------------+"
	
	pause
}

#Purpose - Basic Application Installtion
function basic_install()
{
	#Basic Application Installtion
	echo -e "${CYAN_BG}Basic Application Installtion.${CLEAR}"
	
	
	# Update Ubuntu and get standard repository programs
	sudo apt update
	sudo apt full-upgrade -y

	function install 
	{
	  which $1 &> /dev/null 

	#$1 will take the vlc and check its available binary
	#$? if the application is binary is installed it will return 0 else 1 (returns the exit code of last command)
	  if [ $? -ne 0 ]; then
	    echo "------------------------"
	    echo "Installing: ${1}..."
	    echo "------------------------"
	    sudo apt install -y $1
  
	  else
	   echo "------------------------"
	   echo "Already installed: ${1}"
	  echo "------------------------"
	  fi
	}

	# Basic Application
	install vlc
	install vim
	install chrome
	
	# Image processing
	install gimp


	# Get all upgrades
	sudo apt upgrade -y
	sudo apt autoremove -y
	
	echo "+------------------------------------------+"
				
	#echo -e "${BLUE_BG_BOLD}System is Ready to use!!${CLEAR}"
	zenity --info --title="Installation completed" --text="System is Ready to use!!" --no-wrap
	
	echo "+------------------------------------------+"
	pause
}



# Purpose - On Demand Application Installtion
function ondemand_install()
{
	#Application Installtion
	echo -e "${CYAN_BG}Application Installtion${CLEAR}"
	
	echo -n "Enter name to be Application Installtion: "
	read appname;

	#Replace a b c d e with the applications name you want to install in one go like LIST_OF_APPS="vlc chrome"
	#LIST_OF_APPS="a b c d e"
	#apt update
	#apt install -y $LIST_OF_APPS

	sudo apt update; # To get the latest package lists
	sudo apt install $appname -y;
	
	echo "+------------------------------------------+"
				
	#echo -e "${BLUE_BG_BOLD}System is Ready to use!!${CLEAR}"
	zenity --info --title="Installation completed" --text="System is Ready to use!!" --no-wrap
	
	echo "+------------------------------------------+"
	
	pause
}

# Purpose - On Demand Application Uninstallation
function ondemand_uninstall()
{
	#Application UnInstalltion
	echo -e "${MAGENTA_BG}Application Uninstallation${CLEAR}"
	
	echo -n "Enter the name of the application you want to uninstall here: "
	read appname
	
	#Replace a b c d e with the applications name you want to uninstall in one go like LIST_OF_APPS="vlc chrome"
	#LIST_OF_APPS="a b c d e"
	#apt remove -y $LIST_OF_APPS
	
	sudo apt remove $appname --purge -y;
	
	echo "+------------------------------------------+"
				
	#echo -e "${BLUE_BG_BOLD}System is Ready to use!!${CLEAR}"
	zenity --info --title="UnInstallation completed" --text="System is Ready to use!!" --no-wrap
	
	echo "+------------------------------------------+"
	
	pause
}

# Purpose - On Demand Backup
function ondemand_bkup()
{
	#On Demand Backup
	echo -e "${BLUE_BG}On Demand Backup.${CLEAR}"
	
	# Backup to User Home directory.
	#####################################

	#What to backup. 
	#backup_files="$REPLY"
	backup_files="/home/$USER"

	# Where to backup to.
	dest="/home/$USER"

	# Create archive filename.
	day=$(date +%A)
	hostname=$(hostname -s)
	archive_file="$hostname-$day.tgz"

	# Print start status message.
	echo "Backing up $backup_files to $dest/$archive_file"
	date
	echo

	#Backup the files using tar.
	#tar czf $dest/$archive_file $backup_files
	tar -czf - $backup_files | (pv -p --timer --rate --bytes > $dest/$archive_file)

	# Print end status message.
	echo -e "${GREEN_BG}Backup Finished${CLEAR}"
	date

	echo "+------------------------------------------+"
				
	echo -e "${BLUE_BG_BOLD}System is Ready to use!!${CLEAR}"
	#zenity --info --title="Backup complete" --text="System is Ready to use!!" --no-wrap
	
	echo "+------------------------------------------+"
	
	#Long listing in $dest
	ls -lh $dest

	pause
}



#Purpose - User Management
function user_mgmt()

{
		
	function adduser()
	{
		echo -e "${RED_BG}Add User${CLEAR}"
	
		#You should be Root user!
		echo -n "Enter Username: "
		read  username
		#read and echo the username in the terminal.

		echo -n "Enter Password: "

		# Password is read silently, thus nothing will appear in place of it.
		read -s password 
		sudo useradd -m -p $(openssl passwd  $password) $username
	
		echo
		echo -e "${GREEN}User has been added to system!${CLEAR}" || echo -e "${RED}Failed to add a user!${CLEAR}" 
	
		pause
	}
	
	#########################Deluser#########################
	
	function deluser()
	{
		echo -e "${RED_BG}Delete User${CLEAR}"
	
		#You should be Root user!
		echo -n "Enter User to be deleted : "
		read  username
		
		#remove home directory and mail spool of the user  
		sudo userdel -r $username
		
		echo
		sleep 2
		echo -e "${GREEN}The system has erased the user!${CLEAR}" || echo -e "${RED}Failed to delete user!${CLEAR}" 
		sleep 2
		pause
	}
		

	#User Management
	echo -e "${YELLOW_BG}User Management${CLEAR}"
	
	echo "1. Add User"
	echo "2. Delete User"
	echo "3. Exit"
	
	#echo -n "Type your selection here [1 -3] " 
	#read choice
	read -p "Type your selection here [1 -3] " choice
	
	case $choice in
	1) adduser ;;
	2) deluser ;;
	3) exit 0 ;;
	*) 
	echo "Only choose from the available 1 to 3 options."
	pause
	esac	
}	


function vm_creation()
{

	echo -e "${CYAN_BG}Virtual Machine Creation${CLEAR}"
	
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
	

	#Start the VM
	VBoxManage startvm $vmname --type gui
	
	pause
}


function vmguesttools()
{

	echo -e "${CYAN_BG}Virtual Machine Guest Tools Installation${CLEAR}"
	
	echo "+------------------------------------------+"
	
	echo -n "Please select Insert Guest Additions CD image from the Virtual Machine menu bar's Devices section by clicking there. This helps to mount the Guest Additions ISO file inside your virtual machine." 
	echo
	
	echo "+------------------------------------------+"
	echo
	
	#reading data from the user
	read -p "Have you used the Virtual Machine menu bar to insert the Guest Additions CD image? (Y/N) " value


	if(($value == "Yes" || $value == "Y" || $value == "y" ))
	then
	{
		echo
		#run this as root
		
		sudo apt update 
		
		#sudo apt upgrade
		
		sudo apt install build-essential dkms linux-headers-$(uname -r)
		
		##sudo mount /dev/cdrom /media/sachin/cdrom
		
		cd /media/$USER/VBox_GA*
		
		#echo -n "Please enter the password"
		./autorun.sh
	}

	fi
	pause
}


function encrypt_file()	
{
	
	echo -e "${CYAN_BG}File Encryption${CLEAR}"
	
	echo "Enter the Exact File Name with extension"
	read file;

	#sudo apt install plocate
	#locate $file

	cd "$(find $HOME -name $file -execdir pwd \; -quit)"
	
	#===================================================#

 	if [ ! -f $file ]
	then
	
	    echo "------------------------"
	    echo "Entered File Name does not exists!"
	    echo "------------------------"
	    echo "Enter the Exact File Name with extension."
	    sleep 5;
  	fi
  
	  if [ $? == 0 ]; then
	   echo "------------------------"
	   echo "File with the entered name Found!"
	  echo "------------------------"
	
	#++++++++++++++++++++++++++++++++++++++++++++++#


	gpg -c $file
	
	#Echo!
	#echo "File encrypted sucessfully..."
	notify-send "Encryption" "File encrypted sucessfully..."
	sleep 2
	echo
	
	#Echo!
	echo "Now I will be removing the original file"
	sleep 3
	rm -rf $file
	fi	
	pause
}

function decrypt_file()	
{
	echo -e "${CYAN_BG}File Decryption${CLEAR}"
	
	#echo "Currently Image files can not be decrypted "
	
	echo "Enter the Exact File Name with extension"
	read file;

	cd "$(find $HOME -name $file -execdir pwd \; -quit)"


	#=====================================================#

 	if [ ! -f $file ]
	then
	
	    echo "------------------------"
	    echo "Entered File Name does not exists!"
	    echo "------------------------"
	    echo "Enter the Exact File Name with extension."
	    sleep 1;
	    exit;
  	fi
  
	  if [ $? == 0 ]; then
	   echo "------------------------"
	   echo "File with the entered name Found!"
	  echo "------------------------"
	
	#++++++++++++++++++++++++++++++++++++++++++++++++++++#


	gpg -d $file > $file.decpt.txt

	echo
	#echo "File decrypted successfully..."
	notify-send "Decryption" "File decrypted sucessfully..."
	sleep 2
	echo
	fi
	
	echo -n "Do you want us to delete the original file? Please confirm. (Y/N): "
	read answer
	if [ "$answer" == Y ];
	then
	rm -rf $file
	
	#echo!
	echo " The file has been successfully deleted...."
	sleep 2
	else
	
	#echo issue
	echo "Thank You."
	sleep 2
	fi

	pause
}	

function firewall()
{


	#Update your operating system regularly for security.
	sudo apt-get install iptables

	#sudo iptables [option] CHAIN_rule [-j target]

	#Check the current status of iptables
	echo 
	echo  "+------------------------------------------+"
	echo  "+------------------------------------------+"
	
	echo  "Current status of iptables: "  
	echo
	sudo iptables -L
	echo  "+------------------------------------------+"
	echo
	
	echo "+------------------------------------------+"
	read -p "Do you want to allow traffic on localhost? (Y/N): " input
	echo "+------------------------------------------+"

	if [ $input == Y ]; then   
	{
	#Allow traffic on localhost
	sudo iptables -A INPUT -i localhost -j ACCEPT
	}
	fi

	echo "+------------------------------------------+"
	read -p "Allow traffic on specific port? (Y/N): " input
	echo "+------------------------------------------+"
	
	if [ $input == Y ]; then   
	{
		#Allow traffic on specific ports
		read -p "Allow traffic on Port? : " input
		sudo iptables -A INPUT -p tcp --dport $input -j ACCEPT

		#For HTTP
		#sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

		#For SSH
		#sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
	
		#For HTTPS	
		#sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
	}
	fi


	echo "+------------------------------------------+"
	read -p "Deny traffic on specific port? (Y/N): " input
	echo "+------------------------------------------+"
	
	if [ $input == Y ]; then   
	{	
		#Deny traffic on specific ports
		read -p "Deny traffic on Port? : " input
		sudo iptables -A INPUT -p tcp --dport $input -j DROP
	
		#For HTTP
		#sudo iptables -A INPUT -p tcp --dport 80 -j DROP
	
		#For SSH
		#sudo iptables -A INPUT -p tcp --dport 22 -j DROP
		
		#For HTTPS	
		#sudo iptables -A INPUT -p tcp --dport 443 -j DROP
	}
	fi


	echo "+------------------------------------------+"
	read -p "Do you want to control traffic by IP address? (Y/N): " input
	echo "+------------------------------------------+"
	
	if [ $input == Y ]; then   
	{
		#Control traffic by IP address
		echo "+------------------------------------------+"
		read -p "Enter your_IP_address_to_authorise: " your_IP_address_to_authorise
		echo "+------------------------------------------+"
		sudo iptables -A INPUT -s $your_IP_address_to_authorise -j ACCEPT
		
		echo "+------------------------------------------+"
		read -p  "Enter your_IP_address_to_block: " your_IP_address_to_block
		echo "+------------------------------------------+"
		sudo iptables -A INPUT -s $your_IP_address_to_block -j DROP
		
		echo
		echo "+------------------------------------------+"
		read -p "Do you want to Control traffic by Range of IP address (Y/N): " input
		echo "+------------------------------------------+"
	
		if [ $input == Y ]; then   
		{	
			echo "+------------------------------------------+"
			read -p "Enter your_start_IP_address-your_end_IP_address: " your_start_IP_address
			echo "+------------------------------------------+"
	
			echo "+------------------------------------------+"
			read -p "Enter your_end_IP_address: " your_end_IP_address
			echo "+------------------------------------------+"
			sudo iptables -A INPUT -m iprange --src-range $your_start_IP_address-$your_end_IP_address -j REJECT
		}
		fi

	}
	fi

	echo "+------------------------------------------+"
	read -p "Do you want to Delete unwanted traffic: Y/N " input
	echo "+------------------------------------------+"
	if [ $input == Y ]; then   
	{
		#Remove unauthorised traffic
		#sudo iptables -P INPUT DROP 
		
		sudo iptables -L --line-numbers

		echo "+------------------------------------------+"
		read -p "Enter Rule to be Deleted: " rule_drop
		echo "+------------------------------------------+"

		#sudo iptables -D INPUT <$rule_drop>
		sudo iptables -D INPUT $rule_drop
	}
	fi


	echo "+------------------------------------------+"
	read -p "Do you want to Flush a Single Chain: Y/N " input
	echo "+------------------------------------------+"
	if [ $input == Y ]; then   
	{
		
		#Single Chain Flush
		#sudo iptables -F INPUT
		echo "+------------------------------------------+"
		read -p "Please enter the Chain to be flushed: " INPUT
		echo "+------------------------------------------+"
		sudo iptables -F $INPUT
	}
	fi

	echo "+------------------------------------------+"
	read -p "Do you really want to Flush All Chain: Y/N " input
	echo "+------------------------------------------+"
	if [ $input == Y ]; then   
	{
		#Remove all chains
		sudo iptables -F
	}
	fi

	echo "+------------------------------------------+"
	read -p "Do you really want to Flush All Rules, Delete All Chains, and Accept All: Y/N " input
	echo "+------------------------------------------+"
	if [ $input == Y ]; then   
	{
		#removing all chains, removing all restrictions, and accepting all
		sudo iptables -P INPUT ACCEPT
		sudo iptables -P FORWARD ACCEPT
		sudo iptables -P OUTPUT ACCEPT
	}
	fi
	
	echo "+------------------------------------------+"
	read -p "Do you really want to Delete all non-default chains: Y/N " input
	echo "+------------------------------------------+"
	if [ $input == Y ]; then   
	{
		#Get rid of all auxiliary chains (-X):
		sudo iptables -X
	}
	fi


	echo "+------------------------------------------+"
	read -p "Do you want to Save the Configuration: Y/N " input
	echo "+------------------------------------------+"
	if [ $input == Y ]; then   
	{
		sudo -s iptables-save -c
		notify-send "Firewall" "Configuration Saved!"
		#Iptables will automatically reload the firewall rules the next time your machine boots.
	}
	fi

	}

# Purpose - Task Automation
function task_automation()
{
		
		####FYI###
		#Backup
		#0 10 * * 1 /etc/scripts/backup.sh #run the script each Monday at 10:00
		#0 2 10 * * /etc/scripts/backup.sh #run the script every month on the tenth
		#*/30 * * * * /etc/scripts/backup.sh #backups for mission-critical directories occur every 30 minutes.
		#*/60 * * * 1,2,3,4,5 /etc/scripts/backup.sh #run the script just from Monday through Friday every 60 minutes.
		######
		
	
		function cron_backup()
		{
			
			#What to execute
			#@daily ~/Project-202017B2005/lib/backup.sh # run backup script every day
			
			#echo "Current crontab:"
			#echo "+------------------------------------------+"
			#crontab -e
			sleep 3
			new_entry="@daily ~/Project-202017B2005/lib/backup.sh"
	    		if ! crontab -l | fgrep -q "$new_entry"; then
					
				#write out current crontab
				crontab -l > mycron
				#echo new cron into cron file
				echo "$new_entry" >> mycron
			
				#Output a final status message.
				echo -e "${GREEN_BG}Job Scheduled!${CLEAR}"
		
				date
				sleep 1
				
				#show the cron jobs connected to a specific user ($USER) 
				sudo crontab -u $USER -l
				sleep 3
				
				#install new cron file
				crontab mycron
				rm mycron
			fi
			pause
		}
	
	function cron_systemupgrade()
	{
		
		#What to execute
		#@weekly ~/Project-202017B2005/lib/systemupgrade.sh >> crontab # run system upgrade script every week
		
		new_entry="@daily ~/Project-202017B2005/lib/systemupgrade.sh"
    		if ! crontab -l | fgrep -q "$new_entry"; then
		
			#write out current crontab
			crontab -l > mycron
			
			#echo new cron into cron file
			echo "$new_entry" >> mycron
		
			#Print end status message.
			echo -e "${GREEN_BG}Job Scheduled!${CLEAR}"
		
			date
			sleep 1
			
			#show the cron jobs connected to a specific user ($USER)
			sudo crontab -u $USER -l
			sleep 3
			
			#install new cron file
			crontab mycron
			rm mycron
		fi
		pause

	}
	
	#Task Automation with Cron
	echo -e "${BLUE_BG}Task Automation${CLEAR}"
	echo	
			
	echo -e "${YELLOW_BG}Job Scheduling${CLEAR}"
	echo "1. Weekly System Upgrade"
	echo "2. Daily Backup"
	echo "3. Exit"
	
	read -p "Type your selection here [1-3] " choice
	
	case $choice in
	1) cron_systemupgrade ;;
	2) cron_backup ;;
	3) exit 0 ;;
	*) 
	echo "Only choose from the available 1 to 3 options."
	pause
	esac	

			
}


# Purpose - Take input using the keyboard, then use case to decide. esac 
function read_input()
{
	local c
	echo  && read -p "Enter your choice [ 1 -12 ] : " c
	case $c in
	1) os_upgrade ;;
	2) basic_install ;;
	3) ondemand_install ;;	
	4) ondemand_uninstall ;;
	5) ondemand_bkup ;;
	6) user_mgmt ;;	
	7) vm_creation ;;
	8) vmguesttools ;;
	9) encrypt_file ;;
	10) decrypt_file ;;
	11) firewall ;;
	12) task_automation ;;
	13) echo  && echo -e "${GREEN_BG}Bye!${CLEAR}"; exit 0 ;;
	*) 
	
	echo
	echo "Please select between 1 to 12 choice only."
	pause
	esac
}

# ignore CTRL+C, CTRL+Z and quit singles using the trap
#trap '' SIGINT SIGQUIT SIGTSTP

#Main logic
while true
do
	clear
	show_menu #display menu
	read_input #user input
done
