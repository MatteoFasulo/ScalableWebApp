#!/usr/bin/env bash
export DOMAIN='YOUR_DOMAIN'

cp $(readlink -f /etc/letsencrypt/live/$DOMAIN/fullchain.pem) ./data/fullchain.pem
cp $(readlink -f /etc/letsencrypt/live/$DOMAIN/privkey.pem) ./data/privkey.pem
cp $(readlink -f /etc/letsencrypt/live/$DOMAIN/cert.pem) ./data/cert.pem
cp $(readlink -f /etc/letsencrypt/live/$DOMAIN/chain.pem) ./data/chain.pem

chmod 444 ./data/fullchain.pem ./data/cert.pem ./data/chain.pem
chmod 400 ./data/privkey.pem

docker compose --verbose up -d
