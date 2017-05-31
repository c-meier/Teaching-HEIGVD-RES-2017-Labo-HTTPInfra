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

* Uses httpd official docker image
	* Default website folder is `/usr/local/apache2/htdocs/` 
* Use a copy of the default configuration
	* Configuration path of httpd is `/usr/local/apache2/conf/`
* Uses the bootstrap's one page template named *Stylish Portfolio*

# Step 2: Dynamic HTTP server with express.js

* Uses node official docker image : version 4.4
* Copy the source files `src` to `/opt/app`.
* Use the Chance module to generate random City and Streetnames.

# Step 3: Reverse proxy with apache (static configuration)

# Step 4: AJAX requests with JQuery

# Step 5: Dynamic reverse proxy configuration

# Load balancing: multiple server nodes

# Load balancing: round-robin vs sticky sessions

# Dynamic cluster management

# Management UI
