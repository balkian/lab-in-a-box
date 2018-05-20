FROM nginx:1.13

ENV DOMAIN="todevnull.com" HUB_INTERNAL="http://jupyter:80" LAB_INTERNAL="gitlab:80" REGISTRY_INTERNAL="gitlab:5000"

COPY init.sh /
COPY snippets/ /etc/nginx/snippets/
COPY conf.d /etc/nginx/conf.d/

CMD /init.sh