function encrypt_file()	
{
	bannerColor 'File Encryption' "cyan" "*"
	
	echo "Enter the Exact File Name with extension"
	read file;

	#sudo apt install plocate
	#locate $file

	cd "$(find $HOME -name $file -execdir pwd \; -quit)"


	gpg -c $file
	echo "I have encrypted the file sucessfully..."
	echo "Now I will be removing the original file"
	rm -rf $file
}

function decrypt_file()	
{
	bannerColor 'File Decryption' "cyan" "*"
	
	#echo "Currently I have a limitation, Image files can not be decrypted "
	
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
}	


