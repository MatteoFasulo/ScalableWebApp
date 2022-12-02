# ScalableWebApp
## Overview
### Target
Build a scalable architecture using sotftware virtualization (Docker) and container orchestration (Docker Swarm / Kubernetes). 
### Architecture
The following image represents the architecture proposed as well as the services implemented on Manager and Worker nodes.

<hr>
![Architecture](https://i.imgur.com/ZHUUYUZ.png)
<hr>

#### Master Node(s)
The master node implements the following services:
- Traefik
- Let's encrypt (managed automatically by Traefik)
- Grafana
- InfluxDB
- ShinyProxy (AWS Cognito Auth Service)
#### Worker Nodes
Worker nodes will run only the WebApp chosen by user.
#### Services
A deep dive into the services used so everyone can understand why we used such services. 
- First of all since all the architecture is based on Docker (Docker Swarm in this case) you might wondering why we chose Traefik over Nginx or Apache as Web Server. Well, this is mainly due to the ease of set up of Traefik. If you have ever configured Nginx you know what I'm talking about. Nginx settings can end up in huge config maps that are hard to read and manage especially in case of many redirects and rules. 
- You might also wondering why Docker Swarm compared to standard Docker containers (with Docker Compose paradigm). 
	- Firstly the Swarm mode is already implemented in Docker Engine so you do not have to install it separetly like docker-compose.
	- Moreover Swarm mode allows you to scale your service just by adding nodes to the swarm and quicky empower all your architecture.
	- Docker-compose lacks of functions that Swarm manages like secret-information storage, auto-recovery of services, rollbacks and healthchecks that in a production evniroment are a **must**.
	- Docker Swarm implements the same docker-compose.yml syntax for services.
