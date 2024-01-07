#!/bin/bash


# Purpose - Perform Update, Upgrade and Autoremoval 

	#System Update, Upgrade and Autoremoval
	echo -e "${BLUE_BOLD}System Update, Upgrade and Autoremoval.${CLEAR}"
	
	#tput smso : to highlight the text between tput smso and tput rmso

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
				
	echo -e "${BLUE_BG_BOLD}System is Ready to use!!${CLEAR}"
	
	echo "+------------------------------------------+"
	
	


