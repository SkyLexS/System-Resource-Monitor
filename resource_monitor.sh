#!/bin/bash

case "$1" in
1)

while :
do

clear


echo "PID USER PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND"


ps -eo pid,user,%cpu,%mem,vsz,rss,time,args --sort=-%cpu | head -n 11


sleep 3
done
	;;
2)
function disk_statistics {

stats=$(cat /proc/diskstats | grep -E "sd[a-z] ")


echo "Device: tps kB_read/s kB_wrtn/s kB_read kB_wrtn"
echo "$stats" | awk '{printf "%-12s %8s %12s %12s %12s %12s\n", $3, $4, $8, $12, $6, $10}'
}


function iostat_like {
while true
do
disk_statistics
sleep 3
done
}


iostat_like
	;;
3)function show_traffic_stats() {

    local interface=$1
    local rx_bytes=$(cat /sys/class/net/$interface/statistics/rx_bytes)
    local tx_bytes=$(cat /sys/class/net/$interface/statistics/tx_bytes)
    echo "Received: $rx_bytes bytes"
    echo "Transmitted: $tx_bytes bytes"
}
while true 
do
show_traffic_stats enp0s3
sleep 3

done
	;;
	*)
	echo Pentru a folosit scriptul tasteaza 1 pentru CPU si memory usage 2 pentru I/O si 3 pentru bandwith
	exit 1
esac	
