for i in $(seq 0 0)
do
         ID=`docker ps -q --no-trunc -af "name=peer0.org1.oslab.com" -af "ancestor=hyperledger/fabric-peer:1.4.1"`
        echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 100000
        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us

         ID=`docker ps -q --no-trunc -af "name=peer1.org1.oslab.com" -af "ancestor=hyperledger/fabric-peer:1.4.1"`
        echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 100000
        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us

         ID=`docker ps -q --no-trunc -af "name=peer0.org2.oslab.com" -af "ancestor=hyperledger/fabric-peer:1.4.1"`
        echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 100000
        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us

         ID=`docker ps -q --no-trunc -af "name=peer1.org2.oslab.com" -af "ancestor=hyperledger/fabric-peer:1.4.1"`
        echo -n $1 > /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us 100000
        cat /sys/fs/cgroup/cpu/docker/"$ID"/cpu.cfs_quota_us
done


