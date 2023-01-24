# this line specifies the base image that the Docker image will be built on. In this case, it is using the official Node.js image version 13 on Alpine Linux, which is a lightweight version of Linux.
FROM node:13-alpine																				

# this line sets environment variables that will be available in the container. In this case, it sets the username and password for the MongoDB database.
ENV MONGO_DB_USERNAME=admin \
    MONGO_DB_PWD=password

# this line runs the command mkdir -p /home/app, which creates a directory named "app" in the "/home" directory.
RUN mkdir -p /home/app

# this line copies the files from the "app" directory in the host machine to the "/home/app" directory in the container.
COPY ./app /home/app

# set default dir so that next commands will execute in /home/app dir
WORKDIR /home/app

# will execute npm install in /home/app because of WORKDIR, which installs the dependencies specified in the package.json file in the "/home/app" directory.
RUN npm install

# no need for /home/app/server.js because of WORKDIR. The command that will be executed when the container is run. In this case, it runs the command node server.js, which starts the Node.js server.
CMD ["node", "server.js"]




    FROM node:13-alpine - 

    ENV MONGO_DB_USERNAME=admin \ MONGO_DB_PWD=password - this line sets environment variables that will be available in the container. In this case, it sets the username and password for the MongoDB database.

    RUN mkdir -p /home/app - this line runs the command mkdir -p /home/app, which creates a directory named "app" in the "/home" directory.

    COPY ./app /home/app - this line copies the files from the "app" directory in the host machine to the "/home/app" directory in the container.

    WORKDIR /home/app - this line sets the working directory for the container to "/home/app", so that any commands that follow will execute in that directory.

    RUN npm install - this line runs the command npm install, which installs the dependencies specified in the package.json file in the "/home/app" directory.

    CMD ["node", "server.js"] - this line specifies the command that will be executed when the container is run. In this case, it runs the command node server.js, which starts the Node.js server.