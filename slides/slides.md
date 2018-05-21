---
title: Docker for research
subtitle: ... and data analysis
author: J. Fernando Sánchez (<jf.sanchez@upm>)
tags: [Docker, CI, research]
date: 2018
abstract: Talk about docker for research and data analysis

---

# Intro  { .white data-background="img/intro.jpg"}

## Before we begin

Code available at:

<https://github.com/balkian/lab-in-a-box>

Live demos at: 

**<https://github.todevnull.com>**

<https://lab.todevnull.com>

<https://hub.todevnull.com>


Feel free to log in, but try not to break them for now 😉


## My name is Fernando and...


![](img/im-a-researcher.jpg)



## At Grupo de Sistemas Inteligentes


:::::::::::::: {.columns}
::: {.column width="50%"}
![](img/gsi.png)
:::
::: {.column width="50%"}
- Machine Learning and Big Data
- NLP and Sentiment Analysis
- Social Network Analysis
- Agents and Simulation
- Linked Data and Semantic Technologies
:::
:::::::::::::::

<http://www.gsi.dit.upm.es>

## And I ❤ Docker


:::::::::::::: {.columns}
::: {.column width="50%"}
![](img/docker.jpg)

:::
::: {.column width="50%"}
* Docker+research for 3+ years
* Advocate for ~2 years
* Internal infrastructure: ansible, k8s and docker
* Teach (with) it
:::

::::::::::::::

## About this talk 

Takeaway: ***you can set up a multi-user data analysis environment with isolation in minutes***

Plus: using docker to perform and share experiments is even easier

Related Meetups:

[Big Data and Machine Learning with Docker](https://www.meetup.com/Docker-Madrid/events/240357800/)

[Using Docker in Machine Learning Projects](https://www.meetup.com/Docker-Madrid/events/237067604/)

# For researchers {.white data-background="img/research.jpg" style="color:white"}

<!-- ## Research is about data -->

<!-- ![The scientific method](img/scientificmethod.png){.noborder height="500px"} -->


## Experiment, publish, repeat


![](img/peerreview.jpg)


## Reproducibility


![[\@ianholmes](https://twitter.com/ianholmes/status/288689712636493824)](img/goodluck.png)

## Obstacles

:::::::::::::: {.columns}
::: {.column width="50%"}

* **Missing data** 
* Bleeding edge tools and libraries
* Throwaway software
   * Hacky
   * Little to no documentation
* Multiple languages

:::
::: {.column width="50%"}
![<https://xkcd.com/1742/>](img/will_it_work.png){ height=80% }
:::

::::::::::::::


## Obstacles

![](img/noidea-pc.png)

## Is it a problem?

![[https://www.nature.com/](https://www.nature.com/news/1-500-scientists-lift-the-lid-on-reproducibility-1.19970)](img/reproducibility.jpg){ height=80% }


## Jupyter notebooks

![](img/jupyter-screenshot.png)

## Jupyter architecture

![<http://jupyter.readthedocs.io>](img/jupyter-architecture.png)


## Docker to the rescue

![[towardsdatascience.com](https://towardsdatascience.com/how-docker-can-help-you-become-a-more-effective-data-scientist-7fc048ef91d5)](img/dockerrescue.png)


## Jupyter/docker-stacks 

![](img/dockerstacks.png){ height=50% }

## Reproducible environment

```bash
docker run --rm -p 8888:8888 \
    -v $(WDIR)/:/home/jovyan/work/ \
    jupyter/scipy-notebook
```

## And friendly, too


```yaml
version: '2'
services:
  jupyter:
    image: jupyter/scipy-notebook
    volumes:
    - "./.nbconfig:/home/jovyan/.jupyter/nbconfig"
    - "./work:/home/jovyan/work/"
    ports:
    - "8888:8888""
```

```bash
docker-compose up
```

## Related projects 

* Using docker images to share trained systems

![<https://gym.openai.com>](img/gym.png){ height=500px }

# For small groups { .white data-background="img/group.jpeg" }


## Requirements

* Shared environments
* Resource sharing
* Easy configuration
* Versioning
* Backups

And **little to no overhead**


## Isolation

![](img/noidea.jpg)

## Jupyterhub


:::::::::::::: {.columns}
::: {.column width="60%"}

![<http://jupyterhub.readthedocs.io/>](img/jhub-parts.png){ height=500px }

:::
::: {.column width="40%"}

#### Authenticators

* Local
* OAuth
* LDAP
* JWT

#### Spawners

* Local
* Docker
* Kubernetes
* Marathon

:::
:::::::::::::::

## More infrastructure

![](img/docker-gitlab.jpg){.noborder height="250px"}
![](img/nextcloud.jpg){.noborder height="250px"}

![](img/sharelatex.jpg){.noborder height="250px"}

# Demo  { data-background="img/party.jpg"}

## It's demo time


![](img/demogods.jpg){ height=80% }

<https://github.todevnull.com>
<https://github.com/balkian/lab-in-a-box>

# Other tools

## Zeppelin

* Alternative to Jupyter

![<https://zeppelin.apache.org/>](img/zeppelin.png)

## CoCalc

* Alternative to Jupyter

![<https://cocalc.org/>](img/cocalc.png){ height=500px }


## Docker-Nvidia

* CUDA for docker

![<https://github.com/NVIDIA/nvidia-docker>](img/dockernvidia.png)

## Jupyter Binder

* Custom Jupyter from git repositories

![<https://mybinder.org/>](img/binder.png){ height=500px }


## Knowledge-Repo

![<http://knowledge-repo.readthedocs.io/>](img/knowledgerepo.png)



# Conclusions

## Lessons learned

* Docker + Docker-compose
  * Reproducible environments (partially)
  * Reduced tooling / experience
  * Ephemeral containers force you to automate/document installation
* Jupyterhub
  * Shared environments
  * Web interface (zero knowledge)
  
## What's missing?

* Roles and permissions
* Backups

* Ideas:
  * Kubernetes?
  * OpenShift?

##  Thanks for listening!

<https://github.com/balkian/lab-in-a-box>

<jf.sanchez@upm.es>

