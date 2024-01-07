#!/bin/bash

#Keeping your operating system up-to-date is essential for security
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
read -p "Allow traffic on localhost (Y/N): " input
echo "+------------------------------------------+"

if [ $input == Y ]; then   
{
	#Allow traffic on localhost
	#sudo iptables -A INPUT -i lo -j ACCEPT
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

	#HTTP
	#sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

	#SSH
	#sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
	
	#HTTPS	
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

	#HTTP
	#sudo iptables -A INPUT -p tcp --dport 80 -j DROP

	#SSH
	#sudo iptables -A INPUT -p tcp --dport 22 -j DROP
	
	#HTTPS	
	#sudo iptables -A INPUT -p tcp --dport 443 -j DROP
}
fi


echo "+------------------------------------------+"
read -p "Control traffic by IP address (Y/N): " input
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
	read -p "Control traffic by Range of IP address (Y/N): " input
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
read -p "Delete unwanted traffic: Y/N " input
echo "+------------------------------------------+"
if [ $input == Y ]; then   
{
	#Delete unwanted traffic
	#sudo iptables -P INPUT DROP 
	
	sudo iptables -L --line-numbers

	echo "+------------------------------------------+"
	read -p "Enter Rule to be dropped: " rule_drop
	echo "+------------------------------------------+"

	#sudo iptables -D INPUT <$rule_drop>
	sudo iptables -D INPUT $rule_drop
}
fi


echo "+------------------------------------------+"
read -p "Flush a Single Chain: Y/N " input
echo "+------------------------------------------+"
if [ $input == Y ]; then   
{
	
	#Flush a Single Chain
	#sudo iptables -F INPUT
	echo "+------------------------------------------+"
	read -p "Enter the Chain to be flushed: " INPUT
	echo "+------------------------------------------+"
	sudo iptables -F $INPUT
}
fi

echo "+------------------------------------------+"
read -p "Flushing a All Chain: Y/N " input
echo "+------------------------------------------+"
if [ $input == Y ]; then   
{
	#Flush All Chains
	sudo iptables -F
}
fi

echo "+------------------------------------------+"
read -p "Flush All Rules, Delete All Chains, and Accept All: Y/N " input
echo "+------------------------------------------+"
if [ $input == Y ]; then   
{
	#Flushing All Rules, Deleting All Chains, and Accepting All
	sudo iptables -P INPUT ACCEPT
	sudo iptables -P FORWARD ACCEPT
	sudo iptables -P OUTPUT ACCEPT
}
fi

echo "+------------------------------------------+"
read -p "Delete all non-default chains: Y/N " input
echo "+------------------------------------------+"
if [ $input == Y ]; then   
{
	#delete all non-default chains (-X):
	sudo iptables -X
}
fi

echo "+------------------------------------------+"
read -p "Save the Configuration: Y/N " input
echo "+------------------------------------------+"
if [ $input == Y ]; then   
{
	sudo -s iptables-save -c
	#The next time your system boots, iptables will automatically reload the firewall rules.
}
fi

