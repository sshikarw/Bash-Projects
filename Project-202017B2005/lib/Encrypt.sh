#!/bin/bash
echo "Enter the Exact File Name with extension"
read file;

#sudo apt install plocate
#locate $file

cd "$(find $HOME -name $file -execdir pwd \; -quit)"


gpg -c $file
echo "I have encrypted the file sucessfully..."
echo "Now I will be removing the original file"
rm -rf $file
