# ScalableWebApp
## Overview
### Target
Build a scalable architecture using sotftware virtualization ([Docker]) and container orchestration ([Docker Swarm] / [Kubernetes]). 
### Architecture
The following image represents the architecture proposed as well as the services implemented on Manager and Worker nodes.

<br>
<img src=https://i.imgur.com/ZHUUYUZ.png>
<br>

#### Master Node(s)
The master node implements the following services:
- [Traefik]
- [Let's Encrypt] (managed automatically by [Traefik])
- [Grafana]
- [InfluxDB]
- [Telegraf]
- [ShinyProxy] (AWS Cognito Auth Service)
#### Worker Nodes
Worker nodes will run only the WebApp chosen by user.
#### Services
A deep dive into the services used so everyone can understand why we used such services. 
- First of all since all the architecture is based on [Docker] ([Docker Swarm] in this case) you might wondering why we chose [Traefik] over [Nginx] or [Apache] as Web Server. Well, this is mainly due to the ease of set up of [Traefik]. If you have ever configured [Nginx] you know what I'm talking about. [Nginx] settings can end up in huge config maps that are hard to read and manage especially in case of many redirects and rules. Also [Traefik] will handle the renewal of TLS certificates with [Let's Encrypt] automatically.
- You might also wondering why [Docker Swarm] compared to standard [Docker] containers (with Docker Compose paradigm). 
	- Firstly the Swarm mode is already implemented in Docker Engine so you do not have to install it separetly like docker-compose.
	- Moreover Swarm mode allows you to scale your service just by adding nodes to the swarm and quicky empower all your architecture.
	- Docker-compose lacks of functions that Swarm manages like secret-information storage, auto-recovery of services, rollbacks and healthchecks that in a production evniroment are a **must**.
	- [Docker Swarm] implements the same docker-compose.yml syntax for services.
- Why [ShinyProxy](https://www.shinyproxy.io/)?
	- Since our initial WebApp was a Shiny App we needed an environment that could host a Shiny App. If you are not familiar with shiny you can skip this part.  At the current state of art there are three ways of hosting a Shiny App:
		- [Shinyapps.io](http://www.shinyapps.io/) - a cloud based free hosting service with no hardware installation or annual purchase contract required.
		- [Shiny Server](https://www.rstudio.com/products/shiny/shiny-server/) - open source server to host multiple shiny apps even behind firewall.
		- [RStudio Connect](https://www.rstudio.com/products/connect/) - commercial on-premises solution to host Shiny applications, R Markdown reports, dashboards and plots, as well as Python-based content, including Flask, Dash, Streamlit and Bokeh. 
	- The open source version of [Shiny Server](https://www.rstudio.com/products/shiny/shiny-server/) has several limitations, including a maximum of 1 R worker thread per application. That feature is not scalable by design, so since our web app involved training a model, we decided to use [ShinyProxy](https://www.shinyproxy.io/) (a more scalable and comprehensive solution). Based on Java Spring boot and [Docker], [ShinyProxy] allows you to scale [ShinyProxy](https://www.shinyproxy.io/) WebApps by associating a [Docker] WebApp container to each user, effectively isolating each instance of your app from the others. Also since [ShinyProxy](https://www.shinyproxy.io/) is a full-fledged WebServer, we can create containers with different Web Apps (whether they are written in R or Python) and the mechanism will be exactly the same, [ShinyProxy](https://www.shinyproxy.io/) will start a new container every time a user launches one of these Web Apps regardless of whether they are Shiny or Python Web Apps. The only precautions will be to create a container for each Web App to be published and to associate a unique identifier to each user in order to be able to distinguish two users who connect to [ShinyProxy](https://www.shinyproxy.io/) (guaranteed through the authentication mechanisms like [AWS Cognito] in this case or any other OAuth based authentication system e.g [KeyCloak])
- [Grafana] and [InfluxDB] ???
	- ShinyProxy natively supports usage statistics monitoring with [InfluxDB], a time-series database which in combination with [Grafana] allows you to monitor performance in near real time.
- [Telegraf]
	- We have implemented Telegraf service for collecting and sending all metrics and events from [Docker Swarm] to [Grafana] monitor. Thanks to that we are allowed to make system telemetry.



[ShinyProxy]: <https://www.shinyproxy.io/>
[ShinyServer]: <https://www.rstudio.com/products/shiny/shiny-server/>
[Docker]: <https://www.docker.com/>
[Docker Swarm]: <https://docs.docker.com/engine/swarm/>
[Kubernetes]: <https://kubernetes.io/>
[Traefik]: <https://traefik.io/>
[Let's Encrypt]: <https://letsencrypt.org/>
[Grafana]: <https://grafana.com/>
[InfluxDB]: <https://www.influxdata.com/>
[AWS Cognito]: <https://aws.amazon.com/cognito>
[KeyCloak]: <https://www.keycloak.org/>
[Telegraf]: <https://www.influxdata.com/time-series-platform/telegraf/>
[Nginx]: <https://www.nginx.com/>
[Apache]: <https://httpd.apache.org/>
