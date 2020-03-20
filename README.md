# docker-traefik
A reverse proxy / load balancer that's easy, dynamic, automatic, fast,
full-featured, open source, production proven, provides metrics,
and integrates with every major cluster technology... No wonder it's so popular!

## Setup
1. clone the repo
2. create `.env` file from `.env.example`
3. create your `traefik.toml` file from one of supplied templates:
   - traefik.toml.example - allow http and https
   - traefik-ssl.toml.example - redirect http to https 
4. place cert files in `certs` folder 

```
The default user and password for the dashboard is admin/admin.
make sure to generate a new password using 'htpasswd' and
replace it in your '.env' file
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
 