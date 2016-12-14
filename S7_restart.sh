#OrionsSoftware 2016
#Script per il ripristino di CGMINER

#!/bin/bash
sleep 3m
alertvalue=15
loops=0
maxloops=5
while [ 1 -gt 0 ]
do

app_cpu=`top -n1 | grep cgminer | grep -v {screen} | grep -v grep | awk {'print $8'}`
app_cpu=${app_cpu/%/}

if [ $app_cpu -lt $alertvalue ]; then
echo "Primo test negativo CPU="$app_cpu
sleep 2m

if [ $app_cpu -lt $alertvalue ]; then
echo "Secondo test negativo="$app_cpu
/etc/init.d/cgminer.sh restart >/dev/null 2>&1
echo $(date)" restart services!">>/var/log/restart_miner.log
loops=loops+1

if [ $loops -gt $maxloops ]; then
echo "Terzo test negativo:Procedo al riavvio"
echo $(date)" reboot!">>/var/log/restart_miner.log
reboot
fi

fi

fi
sleep 4m

done
