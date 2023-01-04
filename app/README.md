# How to start
## Docker
If Docker is not installed on the server, the command to run is the following:
```sh
curl -fsSl https://get.docker.com/ -o get-docker.sh && sh get-docker.sh
```

## Networking
If the firewall is enabled, the following ports must be opened:
- 80/tcp # http
- 443/tcp # https
- 2377/tcp # docker swarm
- 4789/udp # docker swarm
- 7946 # docker swarm

## Domains
To be able to use this application you will need to point three different domains to your public IP address:
- {APP_DOMAIN} -> PUBLIC IP ADDRESS
- {TRAEFIK_DOMAIN} -> PUBLIC IP ADDRESS
- {GRAFANA_DOMAIN} -> PUBLIC IP ADDRESS

## Environment
In order to launch the application it is necessary to define some environment variables and save them in a file called `secrets.sh` in the same folder as `start.sh`:

| Variable Name | Description |
| ------ | ------ |
| APP_DOMAIN | web address of the public site to access |
| EMAIL | email address for support and assistance of both web certificates and the application |
| SMTP_MAIL_USER | SMTP server username for sending emails |
| SMTP_MAIL_PASSWORD | SMTP server password for sending emails |
| SMTP_MAIL_HOST | SMTP server host for sending emails |
| TRAEFIK_DOMAIN | web address of Traefik dashboard |
| TRAEFIK_USERNAME | username of the traefik dashboard for access |
| TRAEFIK_PASSWORD | password of the traefik dashboard for access |
| GRAFANA_DOMAIN | web address of the dashboard of Grafana |
| ADMIN_USER | username of the dashboard of grafana |
| ADMIN_PASSWORD | grafana dashboard password |
| CLIENT_ID | AWS Cognito User Pool client ID |
| CLIENT_SECRET | AWS Cognito User Pool client secret |
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
