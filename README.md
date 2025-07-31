# demo.projectblacklight.org

This is an example of a Blacklight powered application with minimal configuration.

This runs in Docker.

There is a compose.yaml file that can be used to run the application locally. It defines the services required to run the application:
* Solr
* mysql

# Build
You must build the application by running `docker compose build app`.

# Run
Then you can run the services by running `docker compose up mysql solr`.

In another window run:

`SECRET_KEY_BASE=1 docker compose up app`

Then you should be able to access the application at http://localhost:3000.

## Console access
If you'd like to connect to the Rails console, run:

`docker compose exec  app bin/rails console`


## Demo documents

Add some documents to the Solr index by running:
```
bin/rake blacklight:index:seed
```

## Clean up
To rebuild cleanly, you may need to run `docker compose down --volumes --rmi all` before rebuilding.
