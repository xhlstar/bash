#!/bin/bash
#File="/etc/passwd"
#pass=`cat $File`
#echo $pass


cd /var
let num=0
for i in /var/*
do 
        let num+=1
	echo $i
done
echo "count $num"



file="/etc/passwd"
array="2 4 6 8 10 15"
for i in $array
do
	exec 3>/tmp/mypasswd
	line=`head -$i $file | tail -1`
	echo "$line"
	#echo "$line" >&3
	echo "$line" >> /tmp/mypasswd
	#exec 3>&-
	cat /tmp/mypasswd
done

