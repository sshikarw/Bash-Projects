#!/bin/bash

#####################################
# Job Scheduling for logged-in User.
#####################################

#Change ~ with the your own project directory
#Importing Libraray file 
source ~/Project-202017B2005/lib/systemupgrade.sh #SystemUpgrade
source ~/Project-202017B2005/lib/backup.sh #DailyBackup

####FYI####
1st character, * — Minute of the Day
2nd character, * * — Hour of the Day
3rd character, * * * — Day of the Month
4th character, * * * * — Month of the Year
5th character, * * * * * — Day of the Week (0–7, Sunday is both represented by a 0 and 7)

@reboot — When the system reboots, command will be executed.
@daily — every day
@midnight — every midnight
@weekly — every week, once.
@yearly — one once a year. The @annually keyword is also available.
####


# Purpose - Task Automation
function task_automation()
{
	#Task Automation
	echo -e "${BLUE_BG}Task Automation${CLEAR}"
	echo	
		
	echo -e "${YELLOW_BG}Job Scheduling${CLEAR}"
	echo "1. Weekly System Upgrade"
	echo "2. Daily Backup"
	echo "3. Exit"
	
	read -p "Type your selection here [1-3] " choice
	
	case $choice in
	1) cron_backup ;;
	2) cron_systemupgrade ;;
	3) exit 0 ;;
	*) 
	echo "Only choose from the available 1 to 3 options."
	pause
	esac	
}	


	####FYI###
	#Backup
	#0 10 * * 1 /etc/scripts/backup.sh #run script every Monday 10am 
	#0 2 10 * * /etc/scripts/backup.sh #run script on the 10th of every month
	#*/30 * * * * /etc/scripts/backup.sh #back up every 30 minutes ++ mission-critical directory
	#*/60 * * * 1,2,3,4,5 /etc/scripts/backup.sh #run the script every 60 minutes only Monday through Friday
	######
	
	
	function cron_backup()
	{
		#What to execute
		@daily ~/Project-202017B2005/lib/backup.sh # run backup script every day
	
		# Print end status message.
		echo -e "${GREEN_BG}Job Scheduled!${CLEAR}"
		
		date

		#display the cron jobs associated with a certain user ($USER) 
		sudo crontab -u $USER -l
		pause
	}
	
	function cron_systemupgrade()
	{
		#What to execute
		@weekly ~/Project-202017B2005/lib/systemupgrade.sh # run system upgrade script every week
		
		
		# Print end status message.
		echo -e "${GREEN_BG}Job Scheduled!${CLEAR}"
		
		date

		#display the cron jobs associated with a certain user ($USER) 
		sudo crontab -u $USER -l
		pause

	}
	
			
}

