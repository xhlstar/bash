#!/bin/bash
#echo $*'#'
var="This is a line of text"
echo ${var/line/REPLACE}
echo "what is your name"
#set name=$<
if(true)then
	echo "True"
else
	echo "False"
fi

echo "This is xuhl's script"
#read name 
echo "my name is $name"
echo -e "what is your full name? \c"

declare -i num
num=hello
echo $?
num=5+5
echo $num
num=4*6
echo $num

declare -i x=017
echo $x
x=2#1011
echo $x
x=8#17
echo $x
x=16#b
echo $x

set 'apple pie' pears peches
for i in $*
do 
	echo $i
done

set 'apple pie' pears peches
for i in "$*"
do 
	echo $i
done

set 'apple pie' pears peches
for i in $@
do 
	echo $i
done

set 'apple pie' pears peches
for i in "$@"
do 
	echo $i
done
name=xuhl
grep "$name" /etc/passwd
echo $?
name=haxu
grep "$name" /etc/passwd
echo $?

x=100
y=200
if ((x>y)); 
then
	echo 'x>y'
else
	echo 'x <y'
fi
