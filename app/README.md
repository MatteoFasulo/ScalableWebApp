# How to start
## Docker
Se Docker non fosse installato nel server, il comando da eseguire è il seguente:
```sh
curl -fsSl https://get.docker.com/ -o get-docker.sh && sh get-docker.sh
```

## Networking
Se il firewall è abilitato bisogna aprire le seguenti porte:
- 80/tcp # http
- 443/tcp # https
- 2377/tcp # docker swarm
- 4789/udp # docker swarm
- 7946 # docker swarm

## Environment
Per poter lanciare l'applicativo è necessario definire alcune variabili d'ambiente e salvarle in un file chiamato `secrets.sh` nella stessa cartella dello `start.sh`:

| Variable Name | Description |
| ------ | ------ |
| APP_DOMAIN | indirizzo web del sito pubblico a cui accedere |
| EMAIL | Indirizzo email per il supporto ed assistenza sia dei certificati web che dell'applicazione |
| SMTP_MAIL_USER | username del server SMTP per l'invio di email |
| SMTP_MAIL_PASSWORD | password del server SMTP per l'invio di email |
| SMTP_MAIL_HOST | indirizzo dell'host del server SMTP per l'invio di email |
| TRAEFIK_DOMAIN | indirizzo web della dashboard di traefik |
| TRAEFIK_USERNAME | username della dashboard di traefik per l'accesso |
| TRAEFIK_PASSWORD | password della dashboard di traefik per l'accesso |
| GRAFANA_DOMAIN | indirizzo web della dashboard di grafana |
| ADMIN_USER | username della dashboard di grafana |
| ADMIN_PASSWORD | password della dashboard di grafana |
| CLIENT_ID | client ID di AWS Cognito User Pool |
| CLIENT_SECRET | client secret di AWS Cognito User Pool |
| AUTH_URL | https://{cognito_domain_prefix}.auth.{region}.amazoncognito.com/oauth2/authorize?response_type=code&client_id={CLIENT_ID} |
| LOGOUT_URL | https://{cognito_domain_prefix}.auth.{region}.amazoncognito.com/logout?client_id={CLIENT_ID}&logout_uri={APP_DOMAIN}/logout-success |
| TOKEN_URL | https://{cognito_domain_prefix}.auth.{region}.amazoncognito.com/oauth2/token |
| JWKS_URL | https://cognito-idp.{region}.amazonaws.com/{POOL_ID}/.well-known/jwks.json |

## Startup
#### Start
```sh
./start.sh start
```
#### Restart
```sh
./start.sh restart
```
#### Stop
```sh
./start.sh stop
```
