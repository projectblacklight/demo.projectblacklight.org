# demo.projectblacklight.org

This is an example of a Blacklight powered application with minimal configuration.

This runs in Docker.

There is a compose.yaml file that can be used to run the application locally. It defines the Solr services required to run the application.

# Build
You must build the application by running `docker compose build app`.

# Run
Then you can run the services by running `docker compose up solr`.

In another window run:

`SECRET_KEY_BASE=1 docker compose up app`

Then you should be able to access the application at http://localhost:3000.

## Console access
If you'd like to connect to the Rails console, run:

`docker compose exec app bin/rails console`


## Demo documents

Add some documents to the Solr index by running:
```
bin/rake blacklight:index:seed
```

## Clean up
To rebuild cleanly, you may need to run `docker compose down --volumes --rmi all` before rebuilding.


## Pre-build image
You can download and run the pre-built image by running:

```
docker pull ghcr.io/projectblacklight/demo.projectblacklight.org:latest
docker volume create my-data-volume
docker run -p 3000:3000  -v my-data-volume:/rails/storage ghcr.io/projectblacklight/demo.projectblacklight.org:latest
```

# Deploy
The app is deployed to https://projectblacklight-demo.stanford.edu with [Kamal](https://kamal-deploy.org).
Solr runs as a Kamal accessory on the same host.

The server uses Kerberos for SSH, which Kamal can't use, so first install a one-time key:

```
kinit
bin/setup-otk
export KAMAL_OTK_KEY=~/.ssh/id_kamal_otk
```

`SECRET_KEY_BASE` and `HONEYBADGER_API_KEY` are read from Vault, so sign in with `vault login -method oidc`.
Export `KAMAL_REGISTRY_PASSWORD` (a GitHub token with `write:packages` scope), then:

```
bin/kamal setup   # first time only: installs Docker, boots Solr and kamal-proxy, deploys the app
bin/kamal seed    # first time only: index the sample documents
bin/kamal deploy  # subsequent deploys
```

Or from the container repo:
```shell
VERSION="$(git rev-parse --short=7 HEAD)" KAMAL_REGISTRY_PASSWORD=secret KAMAL_OTK_KEY=~/.ssh/id_kamal_otk bin/kamal deploy --skip-push
```
