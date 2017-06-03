FROM php:7.0-apache
LABEL maintainer Daniel Palumbo <daniel.palumbo@heig-vd.ch>
LABEL maintainer Christopher Meier <christopher.meier@heig-vd.ch>

# Label for Traefik configuration
LABEL "traefik.backend"="httpd-ajax"
LABEL "traefik.frontend.rule"="Host: demo.res.local;PathPrefix: /"
LABEL "traefik.backend.loadbalancer.sticky"="true"

# We copy the web site files.
COPY ./httpdoc/ /var/www/html

