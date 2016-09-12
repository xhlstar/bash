#!/bin/bash

trap "  exit " SIGINT SIGTERM
echo this is test command

count=1

while [ $count -lt 10  ]
do
	echo $count
	sleep 5
	let count+=1

done
echo This is end of script
