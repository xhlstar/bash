#!/bin/bash
echo "Dear wang are you ok (y/n)"
read answer
if [ "$answer" = y -o "$answer" = Y ]	
then
	echo "Glad to hear it ."
elif [[ $answer = [Nn] ]]
then
	echo "I'm not happy"
fi

if [ $answer = y -o $answer = Y ]
then
	echo "Glad to hear you are happly"
fi 

if [[ $answer = [Nn]o?( way|t really) ]]
then
	echo "So sorry."
fi
echo –n "Choose a foreground color for your xterm window: "
read color
case "$color" in
[Bb]l??)
	xterm –fg blue –fn terminal &
	;;
[Gg]ree*)
	xterm –fg darkgreen –fn terminal &
	;;
red | orange)
	# The vertical bar means "or"
	xterm –fg "$color" –fn terminal &
	;;
*)
	xterm –fn terminal
	;;
esac
echo "Out of case command"
