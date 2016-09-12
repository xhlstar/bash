#!/bin/bash

function alert
{
	if [ "$1" -ne 0 ]
	then
		echo "$2 was failed "
	else
		echo "$2 was successful"
	fi


}
ifconfig 
alert $? "ifconfig eth1231231231"
