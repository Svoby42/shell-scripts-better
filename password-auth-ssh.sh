#!/bin/bash
# This script checks the provided list of IP addresses for SSH with password authentication
echo "Password only SSH IPs" > result.txt
echo

count=0

while read line
do
	if nmap -p 22 --script ssh-auth-methods $line | grep -q password
	then
		count=$[$count+1]
		echo "Found another... $count."
		echo $line >> result.txt
	fi
done < $1
status=$?
if [ $status -eq 1 ]
then
	echo "------------"
	echo "Error"
	echo "Please provide a file with IPs as an argument"
else
	
	echo "Found a total of $count IPs with an SSH password authentication"
fi

