
pre_tps = 
cur_tps = $tps


if [ ${cur_tps} < ${user_tps} || ${cur_tps} < ${pre_tps} ] ; then
for i in $(seq 0 0)
do
	 ID=`docker ps -q --no-trunc -af "name=orderer0.example.com"`
	echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 200000
	cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us

         ID=`docker ps -q --no-trunc -af "name=orderer1.example.com"`
        echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 200000
        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us

         ID=`docker ps -q --no-trunc -af "name=orderer2.example.com"`
        echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 200000
        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us

#         ID=`docker ps -q --no-trunc -af "name=kafka3"`
#        echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 200000
#        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us
done
fi
