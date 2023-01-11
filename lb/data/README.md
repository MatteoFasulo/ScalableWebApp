# SSL certificate
### server.conf
You will need to update `server.conf` to change X.X.X.X to the public IP address of the VMs you will be using as manager nodes in the Swarm. Furthermore you will have to change the writing `YOUR_DOMAIN` with your domain for which you have generated the certificates for.
> **Update**: `X.X.X.X` with IPv4 Address of your VM (manager)

> **Update**: `YOUR_DOMAIN` with domain for which you have generated the certificates for

### nginx.conf
> **Update**: `LB_IPv4_ADDRESS` with IPv4 Address of your Load Balancer VM
