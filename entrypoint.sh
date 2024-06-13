#!/bin/sh

echo "Starting Nginx"

# Replace placeholders with environment variables
envsubst < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Start Nginx
nginx -g 'daemon off;'
