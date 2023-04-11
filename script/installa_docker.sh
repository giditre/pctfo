#!/bin/bash
# controlla che lo script sia eseguito con privilegi di amministratore
if ! [[ $(id -u) == "0" ]] ; then
	  echo "Errore! Invoca questo script come root oppure usando sudo"
	    exit 1
fi
# rimuovi eventuali versioni vecchie di Docker
apt remove docker docker-engine docker.io containerd runc
# aggiorna elenco pacchetti installabili
apt update
# installa pacchetti necessari per scaricare Docker
apt install -y ca-certificates curl gnupg lsb-release
# aggiungi chiave di autenticazione e verifica con fingerprint per repository Docker
mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# aggiungi il repository di Docker tra quelli noti al sistema
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
# riaggiorna elenco di pacchetti installabili (che ora includono quelli del repo di Docker)
apt update
# installa Docker
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# prova Docker
docker run hello-world
