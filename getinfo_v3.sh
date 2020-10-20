#!/bin/bash

ID=`docker ps -q --no-trunc -af "name=peer0.org1.oslab.com" -af "ancestor=hyperledger/fabric-peer:1.4.1"`
NAME=/var/lib/docker/containers/"$ID"/"$ID"-json.log

monitor()
{
#while true;
#do
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
#	tps=`echo "scale=2;$tx/($end_t-$start_t)" | bc -l`
	tps=`echo "scale=0;$tx/($end_t-$start_t)" | bc -l`
	echo $tps
#	return $tps
#        if [[ ("$tps"-lt"$st") && ("$tps"-gt"$st_min") ]]; then sh ./quota_set.sh fi
#        python /home/oslab/caliper_v0.1.0/jskim/quota_daemon.py
return $tps
#sleep 1;
#done
}

controller()
{
#1: user_tps or cur_tps
#2: monitor + pre_tps
#3: bandwidth
echo "user: $1, monitor: $2"

if [ $1 -gt $2 ] ; then
#for i in $(seq 0 0)
#do
	ID=`docker ps -q --no-trunc -af "name=orderer0.oslab.com"`
#        echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 200000
	echo -n 20000 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us
        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us

        ID=`docker ps -q --no-trunc -af "name=orderer1.oslab.com"`
        echo -n 20000 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us
        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us

        ID=`docker ps -q --no-trunc -af "name=orderer2.oslab.com"`
        echo -n 20000 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us
        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us
#done
echo "success"
fi
}


echo "throughput: "
read user_tps

while true;
do
	cur_tps=`monitor`
	echo $cur_tps

	controller ${user_tps} ${cur_tps}
	echo "---------- QiOi running ----------"
	monitor
sleep 3;
done

