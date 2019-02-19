# docker-traefik
A reverse proxy / load balancer that's easy, dynamic, automatic, fast,
full-featured, open source, production proven, provides metrics,
and integrates with every major cluster technology... No wonder it's so popular!

## Setup
1. clone the repo
2. edit .env file
3. select your toml file:
 - traefik.toml - allow http and https
 - traefik.ssl.toml - redirect http to https 

optional:
Comment the 8080 port in docker-compose and use port 80/443.
you can use a local url to access your Traefik dashboard instead using the .env file.

## Network settings:
The stack is divided into three networks: proxy, backend and frontend.

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

there is a 'connect.sh' script included that will connect your Traefik container to all of your
frontend networks. you only need to run it after creating a new stack.
the connection is persistent and will remain between reboots and up/down commands.
you can run the scrip multiple times, it will output an error if the connection already exist. 
