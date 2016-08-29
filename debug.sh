#!/bin/bash
data="xuhl eyang troy jianle"
function DEBUG()
{
	echo $_DEBUG
	[ "$_DEBUG" == "on" ] && $@ ||:
}
for i in {1..10}
do 
	DEBUG echo $i
done

for item in $data
do
	echo name:$item
done
line="root:x:0:0:root:/root:/bin/bash"
oldIFS=$IFS
IFS=":"
count=0 
for item in $line
do
[ $count -eq 0 ] && user=$item
[ $count -eq 6 ] && shell=$item
let count++
done
IFS=$oldIFS
echo $user\'s shell is $shell
