#!/bin/bash


# Update Ubuntu and get standard repository programs
sudo apt update && sudo apt full-upgrade -y

function install {
  which $1 &> /dev/null 

#$1 will take the vlc and check its available binary
#$? if the application is binary is intalled it will return 0 else 1
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

# Basics
install vlc
install vim

# Image processing
install gimp


# Get all upgrades
sudo apt upgrade -y
sudo apt autoremove -y
