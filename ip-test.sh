#!/bin/bash 
 
NOW=$(date +"%m/%d/%Y")

LOG=${PWD}/"ip.log"

MAIL="/bin/mail"

# email subject
SUBJECT="Latest IP address"

# Email To ?
EMAIL="zareba.pawel@gmail.com"

# Email text/message
EMAILMESSAGE="/tmp/emailmessage.txt"

function ext-ip () { curl http://ipecho.net/plain; echo; }

#read old ip 

NEWIP=$(ext-ip)

#check if log file is there
touch $LOG || exit

OLDIP=$(head -n 1 $LOG)

#if ip not updated skip 
if [ "$NEWIP" != "$OLDIP" ]
then
	echo "New IP detected"
	echo $NEWIP > $LOG
	#send email	
	echo "New IP is: $NEWIP"> $EMAILMESSAGE
	echo "Date: "$NOW >>$EMAILMESSAGE

	$MAIL -s "$SUBJECT" "$EMAIL" < $EMAILMESSAGE
else
	echo "IP not updated"
fi

