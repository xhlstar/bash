#!/bin/sh
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
#!/bin/bash
fruit=apple
count=5
echo "we have $count ${fruit}(s)"
#!/bin/bash
printf "%-5s %-10s %-4s\n" No Name Mark
printf "%-5s %-10s %-4.2f\n" 1 Sarath 80.3456
printf "%-5s %-10s %-4.2f\n" 2 James 90.9989
printf "%-5s %-10s %-4.2f\n" 3 jeff 77.564
#!/bin/sh
echo -n Count:
tput sc
set +v
count=0;
while true
do 
if [ $count -lt 40 ]; then 
	let count++
	sleep 1;
	tput rc
	tput ed
	echo -n $count
else 
	exit 0 
fi
done
#!/bin/bash
