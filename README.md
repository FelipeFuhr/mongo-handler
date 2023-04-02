# Mongo Handler

This service provides an interface to interact with Mongo. This approach has many advantages, such as increased security and decoupling of the applications that compose your solution .

## Prerequisites
You have to have Docker and Kubernetes to run every example here. Go is not directly required, but highly recommended .

# Run
The purpose is to illustrate the usage of mongo-handler with a dummy mongo database .

## Build containers
Builds a container named mongo-handler, a dummy mongo-db and another auxiliary containers (such as curl, for testing) .
```
make build
```

## Run containers
Runs pods/containers using kubernetes. Also, creates resources that are necessary (or advisable) for the example to run . 
```
make kube
```

## Todo
- Tests (please!)
- Make handler more generic (maybe include other dbs besides mongo, for example)
- Documentation
- TLS/mTLS
- ...