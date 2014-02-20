#!/bin/sh
alert="duncan@netring.co.uk"
hot=42
res=`/usr/bin/cgminer-api stats | awk 'NR==1' | awk -F'[,*=]' '{for(i=0;i<NF;i++){if($i=="temp1")print $(i+1), $(i+3);};}'`

for temp in $res
do
if [ $temp -gt $hot ]
then
        echo -e "Subject: Alert Hot Miners $temp Attempting Shutdown.\nThe ant miner has got hot please investigate." | ssmtp -v $alert
        echo "The miners are getting very hot they are currently at : $temp trying to kill the miner"
        killall -9 cgminer
        break
else
        echo "The miners are ice cool they are at $temp"
fi
done
