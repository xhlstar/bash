 #!/bin/sh
# dialog --menu "Sys Admin Menu " 20 30 10 1 "Display disk space" 2
tmpfile=tmp.txt

dialog --title  "This is my fisrt dialog" --yesno "Are you sure your selection " 30 60
echo $? >$tmpfile
#cat tmpfile > $temp
temp=`cat $tmpfile`
echo $temp is 

case "$temp" in
	0)
	echo "Yes I'm sure what i select"
	;;
	1)
	echo "let me think about it "
	;;
	*)
	echo "default "
	;;
esac	
