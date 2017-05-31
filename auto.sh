#!/bin/bash -x

CONTAINER_STARTED_FILE=.autoContainers.txt

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
	docker build ./docker/httpd-static -t res/httpd-static
	docker run -d --name "httpd-static" -p 8080:80 res/httpd-static >> $CONTAINER_STARTED_FILE
	xdg-open "http://127.0.0.1:8080"
}

function start_step2
{
	echo "Starting step 2 !"	
	docker build ./docker/express-dynamic -t res/express-dynamic
	docker run -d --name "express-dynamic" -p 3000:3000 res/express-dynamic >> $CONTAINER_STARTED_FILE
	xdg-open "http://127.0.0.1:3000"
}

## Main

case $1 in
	"stop" ) stop_all
		;;
	"step1" ) start_step1
		;;
	"step2" ) start_step2
		;;
	  * ) show_help
esac

