#!/bin/bash
docker exec -it mailserver \
    sendmail you@example.com <<EOF
Subject: Test Mail
From: test@${DOMAIN}
To: you@example.com

Ceci est un mail de test envoyé via docker-mailserver.
EOF
