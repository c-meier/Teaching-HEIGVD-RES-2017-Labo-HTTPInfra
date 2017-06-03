FROM node:4.4 
LABEL maintainer Daniel Palumbo <daniel.palumbo@heig-vd.ch>
LABEL maintainer Christopher Meier <christopher.meier@heig-vd.ch>

# Label for Traefik configuration
LABEL "traefik.backend"="express-dynamic"
LABEL "traefik.port"="3000"
LABEL "traefik.frontend.rule"="Host: demo.res.local;PathStrip: /api/streets/"
LABEL "traefik.backend.loadbalancer.sticky"="false"

COPY ./src /opt/app

EXPOSE 3000

CMD ["node", "/opt/app/index.js"]
