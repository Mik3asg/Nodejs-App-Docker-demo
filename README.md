# docker-js-app-demo
=======
# Node.js with MongoDB Docker App Demo

This demo app shows a simple user profile app using the following components:
- index.html with pure js and css styles
- nodejs backend with express module
- mongodb for data storage
- mongo-express for web-based MongoDB admin interface

All components are docker-based

## With Docker

### To start the application

Step 1: create docker network

    docker network create mongo-network 

Step 2: start mongodb 

    docker run -d -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=password --name mongodb --net mongo-network mongo    

Step 3: start mongo-express
    
    docker run -d -p 8081:8081 -e ME_CONFIG_MONGODB_ADMINUSERNAME=admin -e ME_CONFIG_MONGODB_ADMINPASSWORD=password --net mongo-network --name mongo-express -e ME_CONFIG_MONGODB_SERVER=mongodb mongo-express   

_NOTE: Creating docker-network is in optional. You can start both containers in a default network. In this case, just emit `--net` flag in `docker run` command_

Step 4: check Docker images status
    
    docker images 

Step 5: check Docker containers running status
    
    docker ps

Step 6: open mongo-express from browser

    http://localhost:8081

Step 7: create `my-db` _db_ and `users` _collection_ in mongo-express

Step 8: start your nodejs application locally - go to `app` directory of project 

    npm install 
    node server.js
    
Step 9: access you nodejs application UI from browser

    http://localhost:3000

## With a Dockerfile

A dockerfile contains a script of instructions to build a container image.
Use-case: creating a Docker image from the application hosted in the local dvp environment 

### To build the docker image from the application 

Step 1: once Dockerfile is available - execute the build command

    docker build -t my-app:1.0 .

_NOTE: The dot "." at the end of the command denotes location of the Dockerfile_

Step 2: start the image

    docker run -d -p3000:3000 my-app:1.0

Step 3: check Docker image status (i.e whether the image is running as expected)

    docker images 

Step 4: check Docker container status (i.e whether the container is running as expected)

    docker ps

### To create a private repository for the Docker image on AWS ECR (Elastic Container Registry)

Use-cases: Once Docker image from the app is created with Dockerfile. This can be pushed into a private repository for dvp or tester
to test in a different env. The image is pulled onto a dvp server. MongoDB and Mongo Express can be pulled from the public Docker Hub directory. 
In the event, a new version of the app is released, then a new build process will need to be initiated with a new image

Step 1: create a private repository in AWS ECR

    node-js-mongo-app-demo

Step 2: Docker login to authenticate to AWS ECR Registry

    aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin 990491002634.dkr.ecr.us-west-1.amazonaws.com

_Pre-requisites: AWS CLI needs to be installed and credentials confired on your local machine_
_NOTE: The repository name <990491002634.dkr.ecr.us-west-1.amazonaws.com> will be different in your case_

Step 4: build the Docker image 

    docker build -t node-js-mongo-app-demo .

Step 6: tag your Docker image 

    docker tag node-js-mongo-app-demo:latest 990491002634.dkr.ecr.us-west-1.amazonaws.com/node-js-mongo-app-demo:1.0

Step 7: push the Docker image to the AWS ECR repository

    docker push 990491002634.dkr.ecr.us-west-1.amazonaws.com/node-js-mongo-app-demo:1.0

### To make some changes to the App, rebuild and push a new version to AWS ECR repository

Step 1: modify the content of your nodejs application 

Step 2: since the version of the nodejs application is now different. The build of a new image is required

    docker build -t my-app:1.1 .

_NOTE: 1.1 version for the new image_

Step 3: Run docker image to check status and confirm 1.1 version is available 

Step 4: Push the newly tag/version of the image to the private AWS ECR repository

      docker push 990491002634.dkr.ecr.us-west-1.amazonaws.com/node-js-mongo-app-demo:1.1

_NOTE: 1.1 tag for the new version has been applied_ 

Step 5: Check in the AWS ECR Repository that the 1.1 image version has been upload accordingly 

## With Docker Compose

Docker Compose is a tool for running multi-container applications file in YAML file

### To start the application

Step 1: start mongodb and mongo-express

    docker-compose -f docker-compose.yaml up
    
_You can access the mongo-express under localhost:8080 from your browser_
    
Step 2: in mongo-express UI - create a new database "my-db"

Step 3: in mongo-express UI - create a new collection "users" in the database "my-db"       
    
Step 4: start node server 

    npm install
    node server.js
    
Step 5: access the nodejs application from browser 

    http://localhost:3000

## Docker command

Below are some the most used Docker CLI. The list is not exhaustive.
Alternatively, you can find [The Ultimate Docker Cheat Sheet](https://dockerlabs.collabnix.com/docker/cheatsheet/)

### Run a new container

Start a new container from an image

    docker run IMAGE

... and assign it a name

    docker run --name CONTAINER IMAGE

... and map a port

    docker run -p HOSTPORT:CONTAINERPORT IMAGE

... and start container in background in detached mode

    docker run -d IMAGE

### Manage containers

Show a list of running containers

    docker ps
    
Show a list of all running containers 
    
    docker ps -a

Delete a container

    docker rm CONTAINER

Delete a running containers

    docker rm -f COMTAINER

Delete stopped container

    docker container prune

Stop a running container

     docker stop CONTAINER

Start a stopped container

    docker start CONTAINER

Start a shell inside a running container

    docker exec -it CONTAINER /bin/bash (or /bin/sh)

Rename a container

    docker rename OLD_NAME NEW_NAME

### Manage images

Download an image 
    
    docker pull IMAGE[:TAG]

Upload an image to a repository
    
    docker push IMAGE:<1.0>  

Delete an image
    docker rmi IMAGE

Show a list of images

    docker images

Delete dangling images

    docker images prune 

Delete all unused images

    docker images prune -a

Build and tag an image from a Dockerfile

    docker build -t IMAGE directory 

### Info and stats

Show the logs of a container

    docker logs CONTAINER

Show stats of running containers

    docker stats 

Show installed docker version

    docker version