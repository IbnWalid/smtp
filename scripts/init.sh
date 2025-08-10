#!/bin/bash
set -e
source .env

# Generation certificats SSL
docker compose run --rm certbot

# DKIM
docker compose run --rm mailserver setup config dkim

# DNS
echo "---- ENREGISTREMENTS DNS ----"
echo "MX: ${DOMAIN} -> ${HOSTNAME} (priorité 10)"
echo "A : ${HOSTNAME} -> IP publique"
echo "SPF: v=spf1 mx a ip4:$(curl -s ifconfig.me) -all"
echo "DKIM: $(cat ./config/config/opendkim/keys/${DOMAIN}/mail.txt)"
echo "DMARC: v=DMARC1; p=none; rua=mailto:${EMAIL_ADMIN}"
