import os
import sys
import subprocess
import daemon
import time

i = 0

user_tps = input("throughput: ")
print(user_tps)

os.system("bash /home/oslab/caliper_v0.1.0/qioi_jskim/getinfo_v2.sh")

#os.system("sh /home/oslab/caliper_v0.1.0/qioi_jskim/quota_set.sh")
os.system("sh /home/oslab/caliper_v0.1.0/qioi_jskim/orderer.sh")
