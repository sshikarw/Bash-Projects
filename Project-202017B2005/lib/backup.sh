#!/bin/bash

# Purpose - On Demand Backup

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

	# Long listing of files in $dest to check file sizes.
	ls -lh $dest

	
