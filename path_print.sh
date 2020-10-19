

ID=`docker ps -q --no-trunc -af "name=peer0.org1.example.com" -af "ancestor=hyperledger/fabric-peer:1.4.1"`
NAME=/var/lib/docker/containers/"$ID"/"$ID"-json.log
echo $NAME
sudo cp $NAME ./log.txt
