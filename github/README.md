This deployment contains a single jupyterhub service, with the docker spawner and GitHub Oauth authentication.

Every user will get an isolated docker container after authenticating with GitHub.
The image for that container is configurable through the `DOCKER_IMAGE` environment variable.


# Instructions

Before running docker compose, you need to create a GitHub application: https://developer.github.com/apps/building-github-apps/creating-a-github-app/
Add the client ID and client secret to your `.env` file, or to your environment.


# Example .env file

```
DOMAIN=todevnull.com
GITHUB_CLIENT_ID=<CLIENT ID>
GITHUB_CLIENT_SECRET=<CLIENT_SECRET>
```
