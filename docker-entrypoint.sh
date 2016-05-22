#!/bin/bash -e

service nginx restart
sleep 5
echo "NGINX IS UP.............................................................."
tail -f /var/log/nginx/*
echo "NO LOGS.............."
tail -f /dev/null
