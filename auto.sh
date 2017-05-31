#!/bin/bash -x

CONTAINER_STARTED_FILE=.autoContainers.txt
HOST="demo.res.local"

function show_help
{
	echo "$1 is not a valid argument";
}

function stop_all
{
	echo "Stopping all launched container"
	CONTAINER_STARTED=$(cat $CONTAINER_STARTED_FILE | tr '\n' ' ')
	docker kill $CONTAINER_STARTED
	docker rm $CONTAINER_STARTED
	rm $CONTAINER_STARTED_FILE
}

function start_step1
{
	echo "Starting step 1 !"
	local port=8000
	docker build ./docker/httpd-static -t res/httpd-static
	docker run -d --name "httpd-static" -p $port:80 res/httpd-static >> $CONTAINER_STARTED_FILE
	xdg-open "http://$HOST:$port"
}

function start_step2
{
	echo "Starting step 2 !"	
	local port=3000
	docker build ./docker/express-dynamic -t res/express-dynamic
	docker run -d --name "express-dynamic" -p $port:3000 res/express-dynamic >> $CONTAINER_STARTED_FILE
	xdg-open "http://$HOST:$port/"
}

function start_step3
{
	echo "Starting step 3 !"
	local port=8080
	echo "Do not forget to add $HOST to your hosts file for correct DNS resolving."
	start_step1
	start_step2
	docker build ./docker/httpd-reverse-proxy -t res/httpd-reverse-proxy
	docker run -d --name "httpd-reverse-proxy" -p $port:80 res/httpd-reverse-proxy >> $CONTAINER_STARTED_FILE
	xdg-open "http://$HOST:$port/"
	xdg-open "http://$HOST:$port/api/streets/"
}

## Main

case $1 in
	"step1" ) start_step1
		;;
	"step2" ) start_step2
		;;
	"step3" ) start_step3
		;;
	  * ) show_help
esac

read -p "Press any key to close all docker container ..."

stop_all
