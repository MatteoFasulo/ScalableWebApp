# Load Balancer
We implemented an a priori load balancer before traffic is routed to the Docker Swarm manager nodes. The upstream Nginx configuration will route the request to the manager node with the least number of active connections at that moment (least_conn algorithm). Each of the manager nodes will have an instance of Traefik running to forward requests to ShinyProxy and guarantee a greater fault-tolerance given by the odd number of manager nodes.
> **Fault Tolerance:** Check out the explanation of [why you need an odd number of manager nodes](https://docs.docker.com/engine/swarm/admin_guide/#add-manager-nodes-for-fault-tolerance) and why it's better to have more than just one

> **Tip:** We have changed the 404 and 502 error page with a fancy custom HTML and CSS error page while website is down or unreachable 
