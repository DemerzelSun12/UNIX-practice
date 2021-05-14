#!/bin/sh

#CheckInput
#Check Whether the input is valid
#0 means not valid
CheckInput()
{
	ret=1;

	#Check the number of parameter
	#And Check whether the argument is a folder
	if [ $# -lt 1 ]	
        then
		echo "Please use the command like ./dos2u.sh [Folder]";
		ret=0
	elif [ ! -d $1 ]
	then
		echo "Please use an invalid Folder as the shell argument";
		ret=0
	fi
	
	return $ret;
}

#TraverseFolder
#Traser all the files under the folder
TraverseFolder()
{	
	oldPath=`pwd`
	cd $1;
	for file in `ls`
	do
		if [ -d $file ]
		then 
			TraverseFolder $file;
		else
			#echo $file;
			#sed -i 's/\r//g' $file
			dos2unix $file
		fi	
	done
	cd $oldPath;
}

CheckInput $*
if [ $ret -ne 1 ]
then
	exit -1
fi

TraverseFolder $1
