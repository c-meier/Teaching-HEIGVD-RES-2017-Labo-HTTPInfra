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
	
	# Start step 1
	docker build ./docker/httpd-static -t res/httpd-static
	docker run -d --name "httpd-static" res/httpd-static >> $CONTAINER_STARTED_FILE

	# Start step 2
	docker build ./docker/express-dynamic -t res/express-dynamic
	docker run -d --name "express-dynamic" res/express-dynamic >> $CONTAINER_STARTED_FILE

	docker build ./docker/httpd-reverse-proxy -t res/httpd-reverse-proxy
	docker run -d --name "httpd-reverse-proxy" -p $port:80 res/httpd-reverse-proxy >> $CONTAINER_STARTED_FILE
	xdg-open "http://$HOST:$port/"
	xdg-open "http://$HOST:$port/api/streets/"
}

function start_step4
{
	echo "Starting step 4 !"
	local port=8080
	echo "Do not forget to add $HOST to your hosts file for correct DNS resolving."
	
	# Start ajax
	docker build ./docker/httpd-ajax -t res/httpd-ajax
	docker run -d --name "httpd-ajax" res/httpd-ajax >> $CONTAINER_STARTED_FILE

	# Start step 2
	docker build ./docker/express-dynamic -t res/express-dynamic
	docker run -d --name "express-dynamic" res/express-dynamic >> $CONTAINER_STARTED_FILE

	docker build ./docker/httpd-reverse-proxy -t res/httpd-reverse-proxy
	docker run -d --name "httpd-reverse-proxy" -p $port:80 res/httpd-reverse-proxy >> $CONTAINER_STARTED_FILE
	xdg-open "http://$HOST:$port/"
}

function get_last_container_ip
{
	docker inspect $(tail -n 1 $CONTAINER_STARTED_FILE) | grep "\"IPAddress\"" -m 1 | grep -o "[0-9.]\+"
}

function start_step5
{
	echo "Starting step 5 !"
	local port=8080
	echo "Do not forget to add $HOST to your hosts file for correct DNS resolving."
	
	# Start step 4
	docker build ./docker/httpd-ajax -t res/httpd-ajax
	docker run -d --name "httpd-ajax" res/httpd-ajax >> $CONTAINER_STARTED_FILE
	local ip_http_ajax=$(get_last_container_ip)

	# Start step 2
	docker build ./docker/express-dynamic -t res/express-dynamic
	docker run -d --name "express-dynamic" res/express-dynamic >> $CONTAINER_STARTED_FILE
	local ip_express_dynamic=$(get_last_container_ip)

	docker build ./docker/httpd-dynamic-reverse-proxy -t res/httpd-dynamic-reverse-proxy
	docker run -d --name "httpd-dynamic-reverse-proxy" -e IP_EXPRESS_DYNAMIC=$ip_express_dynamic -e IP_HTTPD_AJAX=$ip_http_ajax -p $port:80 res/httpd-dynamic-reverse-proxy >> $CONTAINER_STARTED_FILE
	xdg-open "http://$HOST:$port/"

	echo $ip_http_ajax $ip_express_dynamic
}

function start_step5b
{
	echo "Starting step 5b !"
	local port=8080
	echo "Do not forget to add $HOST to your hosts file for correct DNS resolving."
	
	# Start step 4
	docker build ./docker/httpd-ajax -t res/httpd-ajax
	docker run -d --name "httpd-ajax" res/httpd-ajax >> $CONTAINER_STARTED_FILE

	# Start step 2
	docker build ./docker/express-dynamic -t res/express-dynamic
	docker run -d --name "express-dynamic" res/express-dynamic >> $CONTAINER_STARTED_FILE

	docker build ./docker/httpd-dynamic-reverse-proxy-b -t res/httpd-dynamic-reverse-proxy-b
	docker run -d --name "httpd-dynamic-reverse-proxy-b" --link=httpd-ajax:httpd-ajax --link=express-dynamic:express-dynamic -p $port:80 res/httpd-dynamic-reverse-proxy-b >> $CONTAINER_STARTED_FILE
	xdg-open "http://$HOST:$port/"
}

## Main

case $1 in
	"step1" ) start_step1
		;;
	"step2" ) start_step2
		;;
	"step3" ) start_step3
		;;
	"step4" ) start_step4
		;;
	"step5" ) start_step5
		;;
	"step5b" ) start_step5b
		;;
	  * ) show_help
esac

read -p "Press any key to close all docker container ..."

stop_all
