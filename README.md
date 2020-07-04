# docker-traefik

Traefik v2 setup with customized security settings.

- All traffic from port 80 is routed to port 443
- Dashboard is SSL secured by default and not accessible in port 8080
- Supports Docker Swarm mode

## Setup
1. clone the repo
2. create `.env` file from `.env.example`
* The default user and password for the dashboard is admin/admin.
make sure to generate a new password using 'htpasswd' and
replace it in your '.env' file

3. create your `conf/traefik.toml` file from `conf/conf.d/traefik.toml.example`
4. create your `conf/certificates.toml` file from `conf/conf.d/certificates.toml.example`
5. create your `conf/tls.toml` file from `conf/tls.toml.example`
6. place cert files to `certs` folder 
7. create your `docker-compose.yml` from `docker-compose.dev.yml`

- to create a `docker-compose.prod.yml` file for docker swarm run:

```
docker-compose config > docker-compose.prod.yml
``` 

## Network settings:
Network name is 'proxy'

When you create a stack make sure it's divided into three networks: proxy, backend and frontend.
the idea behind splitting the stack into three networks
is to block the access of the reverse proxy to the backend containers.

with the Traefik container you will only create the 'proxy' network,
other networks will be created with each stack according to that stack name
to avoid access between frontend/backend containers of different stacks.

- proxy
- stack1_frontend
- stack1_backend
- stack2_frontend
- stack2_backend

and so on...

- request --> traefik --> frontend1 --> backend1
- request --> traefik --> frontend2 --> backend2

there is a 'connect.sh' script included that will connect your Traefik container to all of your
frontend networks. you only need to run it after creating a new stack.
the connection is persistent and will remain between reboots and up/down commands.
you can run the script multiple times, it will output an error if the connection already exist. 

Author: [RaveMaker][RaveMaker].

[RaveMaker]: http://ravemaker.net
 