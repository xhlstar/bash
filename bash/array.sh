#!/bin/bash
if [[ $# -lt 1 ]]
then
	echo "this  is no "
	exit
fi
mytest="a b c d e f g"
echo ${mytest[*]}
echo $*
for item in $mytest
do
	echo $item
done
if true
then
	echo "This is true"
fi
debug=2

test $debug -ge 1 && echo "This is test command"

sudoers=/etc/sudoers

if [ -f $sudoers ]
then
	echo "sudoers is exists"
	if [ -r $sudoers ]
	then
		echo "$sudoers can read "
	else
		echo "can not read $sudoers sorry"
	fi
fi

testarray="eyang troy haxu qq "
for i in $testarray
do
	echo "my name is $i"
done

for j in /home/xuhl/*
do
	echo $j
done
for (( a = 1; a <10 ;a++))
do
	echo $a
done

