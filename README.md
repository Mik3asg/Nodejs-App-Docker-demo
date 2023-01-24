# Node.js with MongoDB Docker App Demo

This demo app shows a simple user profile app using the following components:
- index.html with pure js and css styles
- nodejs backend with express module
- mongodb for data storage
- mongo-express for web-based MongoDB admin interface

All components are docker-based

## With Docker

### To start the application

Step 1: Create docker network

    docker network create mongo-network 

Step 2: start mongodb 

    docker run -d -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=password --name mongodb --net mongo-network mongo    

Step 3: start mongo-express
    
    docker run -d -p 8081:8081 -e ME_CONFIG_MONGODB_ADMINUSERNAME=admin -e ME_CONFIG_MONGODB_ADMINPASSWORD=password --net mongo-network --name mongo-express -e ME_CONFIG_MONGODB_SERVER=mongodb mongo-express   

_NOTE: creating docker-network is in optional. You can start both containers in a default network. In this case, just emit `--net` flag in `docker run` command_

Step 4: check Docker images status
    
    docker images 

Step 5: check Docker containers running status
    
    docker ps

Step 6: open mongo-express from browser

    http://localhost:8081

Step 7: create `my-db` _db_ and `users` _collection_ in mongo-express

Step 8: Start your nodejs application locally - go to `app` directory of project 

    npm install 
    node server.js
    
Step 9: Access you nodejs application UI from browser

    http://localhost:3000

## With a Dockerfile
A dockerfile contains a script of instructions to build a container image

### To build the docker image from the application 

Step 1: after writng the script in Dockerfile, execute the build command

    docker build -t my-app:1.0 .

The dot "." at the end of the command denotes location of the Dockerfile.

Step 2: start the image

    docker run -d -p3000:3000 my-app:1.0

Step 3: check Docker image status / if the image is running

    docker images 

Step 4: check Docker container status /if the container is running

    docker ps

### To create a private repository for a Docker image on AWS ECR (Elastic Container Registry)

Step 1: Create a repository in AWS ECR

Step 2: Retrieve the login command to use to authenticate your Docker client to AWS ECR Registry. 
Execute it in your command prompt

Step 3: Follow the instructions for push commands mentionned in AWS ECR 

Step 4: Make some changes (i.e. change the code line for console.log) to the application server.js file

Step 5: Rebuild new version 1.1

    docker build -t my-app:1.1 . 

Step 6: Execute the docker images command to confirm the new image was built successfully 

Step 7: Push a new version to AWS ECR repo. Check the syntax in AWS ECR 

Note: The login process to AWS here is not required after a new version is released and pushed to AWS ECR 

### With Docker Compose

#### To start the application

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

### Docker command
Below are some the most used Docker CLI. The list is not exhaustive.
Alternatively, you can find [The Ultimate Docker Cheat Sheet](https://dockerlabs.collabnix.com/docker/cheatsheet/)

#### Run a new container


Start a new container from an image

    docker run IMAGE

... and assign it a name

    docker run --name CONTAINER IMAGE

... and map a port

    docker run -p HOSTPORT:CONTAINERPORT IMAGE

... and start container in background in detached mode

    docker run -d IMAGE

#### Manage containers

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

#### Manage images

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