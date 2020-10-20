#!/bin/bash
#ID=`docker ps -q --no-trunc -af "name=peer0.org1.example.com" -af "ancestor=hyperledger/fabric-peer:1.4.1"`
ID=`docker ps -q --no-trunc -af "name=peer0.org1.oslab.com" -af "ancestor=hyperledger/fabric-peer:1.4.1"`
NAME=/var/lib/docker/containers/"$ID"/"$ID"-json.log

while true;
do
#	awk '{/Initializing block stream for iterator/} {init_t[cnt1++]='{print $2}'}' $NAME
	awk '/Initializing block stream for iterator/ {print $2}' $NAME > tmp_t.txt
	awk 'FNR == 5 {print $1}' tmp_t.txt > txinfo.txt
	awk '/[INFO]/&&/Committed block/ {print $2, $14}' $NAME >> txinfo.txt
#        st=550
#        st_min=10
#calculate tps
	#get number of txt line
	n=`cat txinfo.txt | wc -l`
	t1=$(awk 'FNR == '"$n-1"' {print $1}' txinfo.txt)
#	echo $t1
	t2=$(awk 'FNR == '"$n"' {print $1}' txinfo.txt)
#	echo $t2
	tx=$(awk 'FNR == '"$n"' {print $2}' txinfo.txt)
#	echo $tx

#	echo `date -u -d "$t2" '+%s.%N'`
	start_t=$(date -u -d "$t1" +"%s.%3N")
	end_t=$(date -u -d "$t2" +"%s.%3N")
#	echo "s" $start_t
#	echo "e:" $end_t
	tps=`echo "scale=2;$tx/($end_t-$start_t)" | bc -l`
	echo $tps
#	return $tps
#        if [[ ("$tps"-lt"$st") && ("$tps"-gt"$st_min") ]]; then sh ./quota_set.sh fi
#        python /home/oslab/caliper_v0.1.0/jskim/quota_daemon.py
export tps
sleep 1;
done
