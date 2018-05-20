# Your data science lab, in a box

This repository contains two example deployments of a multi-user isolated environments using Jupyterhub.
It is aimed towards small research or data science teams.

The first one authenticates users using GitHub OAuth.

The second one also contains a self-hosted GitLab instance, which can be used for authentication and every else (e.g. CI/CD and docker registry).
It also contains an Nginx service as a reverse proxy

Although these deployments have been tested on a single machine, it can be scaled to multiple nodes using swarm (see https://github.com/jupyterhub/dockerspawner/pull/216).

Note that this is not meant as a guide or complete tutorial.
If you want to learn more about Jupyter(hub)'s architecture and configuration options, check out:

* https://github.com/jupyterhub/jupyterhub-deploy-docker
* https://z2jh.jupyter.org

# What's Jupyter?


Most people associate the Jupyter project (formerly known as ipython server) to the notebooks.
But it is way more than that: it is FANTASTIC project and community!
It includes many actively developed open source projects that go way beyond the original idea of notebooks and kernels.
Moreover, most of these projects are cloud-oriented.
Just to name a few:

* Jupyterhub: http://jupyterhub.readthedocs.io/en/latest/
* Jupyterlab: https://jupyterlab.readthedocs.io/en/stable/
* nbgrader: https://nbgrader.readthedocs.io/en/stable/
* Binder: https://mybinder.org/

In this repository we set up jupyterhub, which extends jupyter by providing multi-user support, authentication and different isolation/deployment options.

# Requirements

* Docker
* Docker-compose
* Docker-machine (recommended)

# Setup

* Create a machine
* Add SSH key
* Configure a DNS wildcard for your domain (if you don't own a domain, check out http://nip.io/ or http://xip.io)
* For convenience, change the SSH port to something other than 22 (e.g. 2222):
```
vi /etc/sshd_config
systemctl restart sshd
```
* Install docker. The easiest way is to use docker-machine:

```
docker-machine create --driver generic --generic-ip-address=lab.todevnull.com  --generic-ssh-key ~/.ssh/id_rsa --generic-ssh-port 2222  labinabox
```
* Set up your environment to start using the remote docker:
```
eval $(docker-machine env labinabox) 
docker info
```
* The docker spawner does not fetch the single-user image automatically, so you will have to pull it manually:
```
docker pull jupyter/scipy-notebook:latest
```
* Create a folder for user homes (workspaces) and give the docker image write permissions:
```
docker-machine ssh labinabox 'mkdir /mnt/home'
docker-machine ssh labinabox 'chown -R 1000:100 -R /mnt/home'
```

# SSL

This demo assumes you have a valid certificate (`/etc/ssl/ssl-custom/cert.pem`) and a key (`/etc/ssl/ssl-custom/key.pem`) for your domain.


## Certbot
You're encouraged to use a valid certificate authority such as letsencrypt.
Using certbot is pretty straightforward.
It even comes bundled in a docker image, and a standalone server:

```
LE_VERSION=v0.14.0
DOMAIN=todevnull.com
docker run -ti --rm -p 80:80 -p 443:443 --name certbot \
    -v '/data/letsencrypt/etc/letsencrypt/:/etc/letsencrypt' \
    -v '/data/letsencrypt/var/lib/letsencrypt:/var/lib/letsencrypt' \
    -v '/var/www/letsencrypt/:/webroot' \
    certbot/certbot:$LE_VERSION certonly --standalone \
    --expand --keep \
    -d hub.$DOMAIN -d lab.$DOMAIN -d registry.$DOMAIN -d github.$DOMAIN -d chat.$DOMAIN -d github.$DOMAIN

```

Now, simply move the generated certificates to the paths the demos expect:

```
docker-machine ssh labinabox "cp -L /data/letsencrypt/etc/letsencrypt/live/hub.$DOMAIN/privkey.pem /etc/ssl/ssl-custom/key.pem"
docker-machine ssh labinabox "cp -L /data/letsencrypt/etc/letsencrypt/live/hub.$DOMAIN/fullchain.pem /etc/ssl/ssl-custom/cert.pem"
```

## Self-signed

For a simple test, you can also generate your own self-signed certificates using openssl:

```
export DOMAIN=<YOUR DOMAIN NAME>
openssl req -x509 -newkey rsa:4096 -keyout ssl-custom/key.pem -out ssl-custom/cert.pem -days 365 -subj "/C=ES/ST=Madrid/L=Madrid/O=Lab in a Box/OU=Org/CN=*.${DOMAIN}"

docker-machine scp -r ssl-custom labinabox:/etc/ssl/
```

# Notes

* Instead of creating a custom image, nginx should rely on the vanilla nginx docker image with configuration as a bind mount, but that requires syncing configuration files with the server.
* **Do not even consider deploying an environment like the one in this demo without a backup strategy**: http://www.taobackup.com/
* Folder permissions should be more restrictive. You can chown the files to the default uid and gid of the jupyter image.
