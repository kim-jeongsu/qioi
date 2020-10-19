for i in $(seq 0 0)
do
	 ID=`docker ps -q --no-trunc -af "name=kafka0"`
	echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 200000
	cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us

         ID=`docker ps -q --no-trunc -af "name=kafka1"`
        echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 200000
        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us

         ID=`docker ps -q --no-trunc -af "name=kafka2"`
        echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 200000
        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us

         ID=`docker ps -q --no-trunc -af "name=kafka3"`
        echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 200000
        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us
done

