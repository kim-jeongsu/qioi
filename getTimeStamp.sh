for i in $(seq 0 0)
do
      awk '/Initializing block stream for iterator/ {print $2}' peer0.txt >> parsed2.txt
      awk 'FNR == 5 {print $1}' parsed2.txt >> tsTime.txt
      cat tsTime.txt
      awk '/Committed block/ {print $2, " ", $12, " ", $14}' peer0.txt >> parsed.txt
      awk 'FNR == 10 {print $1}' parsed.txt >> timestamp.txt
      awk 'FNR == 10 {print $3}' parsed.txt >> tpsNum.txt

      ts1=$(awk 'FNR==10 {print $1}' parsed.txt)
      tps1=$(awk 'FNR==10 {print $3}' parsed.txt)
      ts2=$(awk 'FNR==12 {print $1}' parsed.txt)
      
      timeDiff=$(($(date -d "$ts2" '+%s%N') - $(date -d "$ts1" '+%s%N')))
      printf "%f\n" $timeDiff

      awk 'FNR == 14 {print $1}' parsed.txt >> timestamp.txt
      awk 'FNR == 16 {print $1}' parsed.txt >> timestamp.txt
      awk 'FNR == 18 {print $1}' parsed.txt >> timestamp.txt
      awk 'FNR == 20 {print $1}' parsed.txt >> timestamp.txt
      cat timestamp.txt
      awk 'FNR == 10 {print $3}' parsed.txt >> tpsNum.txt
      awk 'FNR == 12 {print $3}' parsed.txt >> tpsNum.txt
      awk 'FNR == 14 {print $3}' parsed.txt >> tpsNum.txt
      awk 'FNR == 16 {print $3}' parsed.txt >> tpsNum.txt
      awk 'FNR == 18 {print $3}' parsed.txt >> tpsNum.txt
      awk 'FNR == 20 {print $3}' parsed.txt >> tpsNum.txt
      cat tpsNum.txt
done
