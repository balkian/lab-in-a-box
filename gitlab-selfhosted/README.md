This deployment contains:

* Gitlab for code and authentication. The omnibus image is an all-in-one package that contains:
    * Git (`git.domain.com`) and CI/CD 
    * Docker registry (`registry.domain.com`)
    * Mattermost (slack clone, `chat.domain.com`)
    * Postgres db
* Jupyterhub for multi-user computing (`hub.domain.com`)
    * Authentication with Gitlab
    * Every user has an isolated environment (thanks to Docker-spawner)
    * Based on https://github.com/balkian/jupyterhub-oauth
* Nginx as a reverse proxy

# Instructions

Set the `DOMAIN` variable in a `.env` file and run this compose.
After GitLab is loaded, create an OAuth application in Gitlab: https://docs.gitlab.com/ce/integration/oauth_provider.html
The redirect URL is: `https://hub.<your domain>/hub/oauth_callback`.
Click on `API` level and `trusted`.

Write the client ID and client secret to a `.env` file in this folder.

Then, update the Jupyter service.

# Example .env file

```
DOMAIN=<YOUR DOMAIN>
GITLAB_CLIENT_ID=<YOUR ID>
GITLAB_CLIENT_SECRET=<YOUR SECRET>
```

# Advanced configuration

GitLab's documentation is terrific.
For a list of configuration options, see https://docs.gitlab.com/omnibus/docker/#install-gitlab-using-docker-compose .


# Note

When run as part of the omnibus, mattermost should register an application automatically on Gitlab.
I've had some issues with authentication, so if I've explicitly added the OAuth parameters in the compose file.
This way, you can manually register mattermost on your instance.
The process is similar to jupyter, and the callback URLs are:


```
https://chat.$DOMAIN/signup/gitlab/complete
https://chat.$DOMAIN/login/gitlab/complete
```

