import argparse
import json
import requests
import sys

parser = argparse.ArgumentParser(description="Invia dati a Thingsboard.", exit_on_error=False)
parser.add_argument("valore", help="Valore numerico da inviare", type=int)
parser.add_argument("testo", help="Testo da inviare insieme al valore numerico", type=str)
parser.add_argument(
    "-i",
    "--indirizzo",
    help="Indirizzo remoto, default: %(default)s",
    nargs="?",
    default="127.0.0.1:9090",
)
parser.add_argument(
    "-t",
    "--token",
    help="Token di autenticazione, default: %(default)s",
    nargs="?",
    default="qwerty",
)

args = parser.parse_args()

print(f"Argomenti: {json.dumps(vars(args))}", end="\n")

# token = "".join(chr(64 + n) for n in [10, 1, 3, 11])

url = f"http://{args.indirizzo}/api/v1/{args.token}/telemetry"

try:
    r = requests.post(url, json={"value": args.valore, "text": args.testo})
except requests.exceptions.ConnectionError as e:
    print("Errore: problema di connessione")
    sys.exit()

if r.status_code == 401:
    print("Errore: problema di autenticazione")
    sys.exit()

print("Successo!")
