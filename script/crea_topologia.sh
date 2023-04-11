#!/bin/bash

echo "--- Controllo se esistono i container che stanno per essere creati, e nel caso li arresto"
test -n "$(docker container ls -f name=device -f name=gateway -q 2>&1)" && docker container stop $(docker container ls -f name=device -f name=gateway -q)
echo "--- Ripulisco la lista di container eliminando quelli arrestati"
docker container prune -f
echo "--- Ripulisco la lista di reti virtuali eliminando quelle senza container connessi"
docker network prune -f

echo "--- Creo la nuova rete virtuali che interconnette i container"
docker network create --subnet 192.168.3.0/24 -o com.docker.network.bridge.name=br-lan lan

echo "--- Controllo la lista di reti virtuali"
docker network ls

echo "--- Avvio un nuovo container chiamato \"gateway\" e lo lascio connesso alla rete di default"
docker run -dit --hostname gateway --name gateway --cap-add=NET_ADMIN alpine
echo "--- Connetto il container \"gateway\" alla nuova rete virtuale"
docker network connect --ip 192.168.3.254 lan gateway

echo "--- Avvio un nuovo container chiamato \"device\" e lo connetto direttamente alla rete virtuale"
docker run -dit --hostname device --name device --network lan --cap-add=NET_ADMIN giditre/pctfo-device

echo "--- Controllo la lista di container, filtrando solo quelli che mi interessano"
docker container ls -f name=device -f name=gateway

echo "--- Installo il firewall sul container \"gateway\""
docker exec gateway apk add iptables
echo "--- Configuro il firewall sul container \"gateway\""
docker exec gateway iptables -t nat -A POSTROUTING -s 192.168.3.0/24 -j MASQUERADE

echo "--- Elimino le informazioni di routing del container \"device\""
docker exec -u root device ip route del default
echo "--- Elimino le configurazioni IP del container \"device\""
docker exec -u root device ip address flush dev eth0

