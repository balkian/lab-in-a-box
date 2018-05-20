#!/bin/sh
cd /etc/nginx/conf.d/

VARIABLES='${HUB_INTERNAL}${DOMAIN}${LAB_INTERNAL}${REGISTRY_INTERNAL}'
for i in *.template; do
    target=$(basename $i ".template")
    envsubst $VARIABLES < $i > $target;
done || exit 1
nginx -g 'daemon off;'
