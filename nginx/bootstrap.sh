#!/bin/sh

if [ ! -f "/ssl/cert.pem" ]; then
	openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -subj="/C=US/ST=MA/L=Waltham/O=Dynatace/CN=selfservice.local" -keyout /ssl/key.pem -out /ssl/cert.pem
fi

if [ ! -f "/ssl/dhp.pem" ]; then
	openssl genpkey -genparam -algorithm DH -out /ssl/dhp.pem
fi


exec nginx -g 'daemon off;'
