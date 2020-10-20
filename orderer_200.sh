for i in $(seq 0 0)
do
         ID=`docker ps -q --no-trunc -af "name=orderer0.oslab.com"`
        echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 200000
        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us

         ID=`docker ps -q --no-trunc -af "name=orderer1.oslab.com"`
        echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 200000
        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us

         ID=`docker ps -q --no-trunc -af "name=orderer2.oslab.com"`
        echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 200000
        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us

#         ID=`docker ps -q --no-trunc -af "name=kafka3"`
#        echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 200000
#        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us
done

