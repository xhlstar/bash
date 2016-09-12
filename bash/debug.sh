#!/bin/bash

debug=1
echo 'This is my first debug sh'
test $debug -gt 0 && echo 'Debug is on ^_^'
read answer
test $debug -gt 0  && echo "The  answer is $answer"
answer=`echo $answer | tr [a-z] [A-Z]`
echo "answer is $answer"
if [ $answer = Y ]
then
   echo woo you must very skilled
else
   echo let exit baby
fi
