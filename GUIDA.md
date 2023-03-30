Per poter inviare messaggi al server nel Cloud, bisogna configurare correttamente l'indirizzamento IP in questo container, e scoprire la stringa di autenticazione (token).

---

Per configurare l'indirizzamento, utilizzare i comandi `ip` per aggiungere un indirizzo valido all'interfaccia di rete del container, e le necessarie informazioni di instradamento.

---

Per costruire la stringa di autenticazione (una parola di 4 lettere, tutte scritte in maiuscolo) bisogna scoprire 4 numeri, ciascuno dei quali va poi associato alla corrispondente lettera dell'alfabeto internazionale, secondo la logica: 1 --> A, 2 --> B, 3 --> C, 4 --> D, ..., 9 --> I, 10 --> J, 11 --> K, 12 --> L, ..., 22 --> V, 23 --> W, 24 --> X, 25 --> Y, 26 --> Z.

Il primo numero si trova in un file codificato base64 nella cartella principale dell'utente root, ovvero la cartella `/root`, nella quale ci si trova all'accesso del container.

Il secondo numero si trova in un file nascosto nella cartella `/root`.

Il terzo numero si trova in un file contenuto in una delle sottocartelle dentro la cartella `archivio` nella cartella `/root`.

Il quarto numero si trova interagendo tramite il programma `nc` con un processo locale (ovvero all'indirizzo di localhost 127.0.0.1) su una porta TCP che va a sua volta scoperta scansionando le porte in ascolto su localhost con il programma `nmap`.

---

Una volta ottenuta la stringa di autenticazione (anche detta "token"), per inviare i dati si può usare lo script Python denominato `invia.py` contenuto nella cartella `/root`, così:

> python3 invia.py -i INDIRIZZO -t TOKEN VALORE TESTO

dove INDIRIZZO è l'indirizzo del server remoto (chiedetelo), TOKEN è la stringa di autenticazione, VALORE è un numero, TESTO è una stringa.

---

__Non è una gara__, ma "vince" chi riesce a mandare per primo un messaggio mettendo come VALORE la somma dei 4 numeri scoperti e come TESTO il proprio nome o il nome del gruppo di cui fa parte. Ovviamente si può anche provare a mandare valori e testo a piacimento :-)