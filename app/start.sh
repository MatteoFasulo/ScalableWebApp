#!/usr/bin/env bash
service_start() {
source secrets.sh # env variable setup

# Restart Docker in case of residual networks
systemctl restart docker

# Initialize the swarm with advertise address as public ip of VM
docker swarm init --advertise-addr $(dig +short myip.opendns.com @resolver1.opendns.com) # curl ipconfig.io

# Public network for Traefik
docker network create --driver=overlay traefik-public
export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
docker node update --label-add traefik-public.traefik-public-certificates=true $NODE_ID

# Env variables for let's encrypt ssl certificate and password for traefik dashboard
export EMAIL=$EMAIL
export DOMAIN=$TRAEFIK_DOMAIN
export TRAEFIK_USERNAME=$TRAEFIK_USERNAME
export HASHED_PASSWORD=$(openssl passwd -apr1 $TRAEFIK_PASSWORD)

export DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)

# App domain
export APP_DOMAIN=$APP_DOMAIN

# Internal overlay network for all containers behind Traefik 
docker network create --driver=overlay sp-net

# Private image registry for Docker images
#docker stack deploy -c registry.yml registry --with-registry-auth

# Traefik
docker stack deploy -c traefik.yml traefik

# ShinyProxy
docker stack deploy -c shinyproxy.yml shinyproxy

# Grafana and InfluxDB
#export GRAFANA_DOMAIN=$GRAFANA_DOMAIN
docker stack deploy -c usagestats.yml usagestats

# Image push over private registry
#docker push sp.batgames.it:5000/matteofasulo/amazon-dashboard:latest
}

service_stop() {
docker swarm leave -f # leave swarm forcing it 
docker network prune -f # remove all networks avoiding errors
}
case "$1" in
        'start')
        service_start
        ;;
        'stop')
        service_stop
        ;;
        'restart')
        service_stop
        sleep 3
        service_start
        ;;
        *)
        echo "Usage source ./start.sh start|stop|restart"
esac
