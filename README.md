# demo.projectblacklight.org

This is an example of a Blacklight powered application with minimal configuration.

There is a compose.yaml file that can be used to run the application locally. It defines the services required to run the application:
* Solr

# Run
Then you can run the services by running `docker compose up mysql solr`.


Add some documents to the Solr index by running:
```
bin/rake blacklight:index:seed
```


You can start the development server by running:
```
bin/dev
```
