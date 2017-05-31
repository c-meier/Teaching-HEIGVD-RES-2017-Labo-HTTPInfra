---
title: "RES - Labo 5 - HTTP Infrastrucutre"
author: 
	- "Christopher Meier"
	- "Daniel Palumbo"
date: "11 june 2017"

toc: true

geometry: "margin=1in"
---

# Introduction

# Step 1: Static HTTP server with apache httpd

* Creating Dockerfile in `docker/httpd-static` folder.
* Using php official docker image with apache `php:7.0-apache`
	* Default website folder is `/var/www/html` 
* Using the default configuration
	* Configuration path of httpd is `/etc/apache2/`
* Using the bootstrap's one page template named *Stylish Portfolio*

# Step 2: Dynamic HTTP server with express.js

* Creating Dockerfile in `docker/express-dynamic` folder.
* Using node official docker image : version 4.4
* Copying the source files `src` to `/opt/app`
* Using the Chance module to generate random City and Streetnames

# Step 3: Reverse proxy with apache (static configuration)

* Creating Dockerfile in `docker/httpd-reverse-proxy` folder.
* Using php official docker image with apache `php:7.0-apache`
	* Copying the configuration to `/etc/apache2/`
	* Setting the environnement variables to prevent errors
	* Enabling the necessary modules and sites
* Configuring the reverse proxy
	* Hardcoded ip address for other docker container (httpd-static and express-dynamic      
	needed to be started before and in this order)

# Step 4: AJAX requests with JQuery

* Copying `docker/httpd-static` to `docker/httpd-ajax` folder
* Cross-domain policy forbids an ajax query from querying a different domain.
* Load script `httpdoc/js/streets.js` from main page.
	* Ajax request every 2 sec.
	* Show from 1 to 8 street names and city in the *Streets* zone.

# Step 5: Dynamic reverse proxy configuration

# Load balancing: multiple server nodes

# Load balancing: round-robin vs sticky sessions

# Dynamic cluster management

# Management UI
