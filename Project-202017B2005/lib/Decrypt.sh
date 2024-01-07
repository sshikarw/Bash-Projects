#!/bin/bash
echo "Enter the Exact File Name with extension"
read file;

cd "$(find $HOME -name $file -execdir pwd \; -quit)"

gpg -d $file > decpt.txt

echo "I have decrypt the file successfully..."

echo "Please confirm should we remove the original file. Please answer in Y or N"
read answer
if [ "$answer" == Y ];
then
 rm -rf $file
 echo " We have removed the file successfully..."
else
 echo "Thank You."
fi
