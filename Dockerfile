# this is a local and dockerhub image node 
# in my own image i wanna start by pulling in that node image
FROM node:16


# all the subsequent commands will executed inside that folder.
WORKDIR /app

COPY package.json /app

# which file from my local machine will go in that image
# COPY . . 
# 2 paths here , first path is the path outside of the container outside of the image where the files live that should be copy into the image
# with . specifies that is the same file which contains the docker file exclusing the docker file
# the second . is the path inside ot the image 
# Host file system | | | Image/containers file system
# every image has its own intrnal file system which is totally detached from your file system
# app folder will be created inside of image and container
# layer npm install comes first in order not re-executed again again once source fuile changes 
# so whenever we change our source code npm install not executed again and again go to a bigger image layer 
# layer based approach
RUN npm install 

COPY . /app

# after copying all local files run the command inside of image
# by default all those commands will be executing in the working directory of your docker container image
# root folder is the wookinf directoryt 
# RUN npm install -g npm@latest
# RUN npm cache clean --force
# RUN npm rm -rf node_modules && rm package-lock.json


EXPOSE 80

CMD ["node","server.js"]



# image should be the template of the container
# the image is ot what you are run in the end, you run a container based on image
# we want to start a server if we start a container based on an image.
# CMD node server.js will execute when a container is started based on the image
# DOcker cotnainer is isolated from our local environment
# We do not put only our code into an image but also the environment and tools we need to execute that code 
# we do this inside the Dockerfile if we want to open up some internal port so to lksten to that outside from that image 
# for ultimately outside of the container in the end Docker is ultimately about containers not images images are the template , the blueprint for your containers 
# then you can instantiate run multiple containers based on a image

# Image -------------------------> Container
# Our code                         Our code
# Environment                      Environment
#
#--------------------------------> Container
#--------------------------------> Our code
#--------------------------------> Environment
# Container is your running application based on the image 
# A container will use he environment stored in an image, and just add this extra layer on top of it
# Images are "blueprints" for containers which then are running instances with read and writw access
# sudo docker run node ---> It creates and runs a container based on the "node" image
# On any docker command 
# Images can be tagged -t, docker tag
# We can listed images , with the command dokcer images
# Images can be analyzed, docker image inspect
# Images can be removed, docker rmi
# Containers can be named --name
# COntainers Can be configured in detail --help
# Containers can be listed with docker ps
# Containers can be removed with docker rm
# sudo docker start <name_of_container> ---> will come the container back up.
# sudo docker run -p 3000:80 ba2fdc3
# sudo docker run -p 8000:80 ba2fdc3 ---> we are attached to this running container attached means that we are listening to the output of that container
# run different container based on the same image
# the detached mode is the default for running with docker run 
# if you want to restart an container in attached mode 
# sudo docker start -a <name_of_container>
# In a new example with Python app you can download Python on your machine and run that 
# or you put it into a Docker Image and container, 
# In order to remove a container we need to stop this container in first place
# you ca also use sudo docker container prune to remove all stopped containers at once 
# with sudo docker images , list all images
# rm for removing containers and rmi for removing images and all the layers of the image
# we can only removed images if they are not used by any container any more and that includes stopped containers 
# if you have an image being stopped you can not remove images being used by that container
# you need to remove that container first and then remove the image
# no matter if a container is started or stopped images belonging to that container, can not be removed.
# The container need to be removed first.
# if you wanna remove all he images , which are not used in the running containers 
# we use docker image prune 

# with sudo docker run -p 3000:80 -d --rm 2ddf2ede7d6c ---> This will automatically removes acontainer when it's been stopped.

# The running container is then actually not really that big
# With sudo docker image inspect image_id ---> more info about an image

# If you want to add something in a container or extract something from it
# sudo docker cp ---> allows you to copy files into a runnign containers or out of a running container
# let's say we want to add something inside a running containers 
# sudo docker cp dummy/. <container-name>:/test ---> copy a folder inside of a containers
# sudo docker cp <container-name>:/test dummy/ ---> copy a folder from a container inside of my local machine idrecotry 
# this will help you to add something in the container without rebuild your image 
# let's say our source cide has changed we need to rebuild our image because f that and restart the container 
# you can also naming images and containers 
# node image actually has a tag and a repository 
# with sudo docker run -p 3000:80 -d --rm --name <nameOfContainer> imageId ---> add our own name to the containers
# Image tags consists of two parts ---> it is the actual name, also called repository of your image and then a tag seperated by a colon
# name:tag, with the name you can set up the actual name of the imaeg 
# name defines a group of, possible more specialized images
# example of an name : "node" , tag defines a specialized image within a group of images , Example:"14"
# after the world node you can set up multiple options
# Node is general group of images but when we got specialized images which have different tags, we will use exactly the version or the configuration of node.
# sudo docker build -t goals:latest ---> we define an image name 
# sudo docker run -p 3000:80 --rm --name goalsapp goals:latest 
# run a container with name goalsapp based on the image with name goals:latest
# with this way we start a container with name goalsapp based on image with name goals:latest
# tags help to work on different version of the same image
# for example in the node version we have a lot fo specialized versions of that node image
# we want Reliability and Reproducible Environments
# 1) We want to have the exact same environment for development and production ---> THis ensured that it works exactly as tested
# 2) We do not want to uninstall and re-install local dependencies and runtimes all the time
# due to Docker we can have different projects with different dependencies and different versions 
# we use docker to share containers and images with other 
# Everyone who has an image can create containers based on the image
# we build our own images on the Python or node images.
# we can pull these images on DockerHub so we are able to use them to run our own containers, 
# In order to share images we have two ways of doing that , we can either share the Dockerfile 
# if you have the Docekrfile and source code of that application you can build your own image 
# DOckerfile + Source Code ---> Build your own image ---> use that image to run a container
# we use the FROM instruction but again , we just need this image like this 
# docker run node ---> refers to that image 
# Everyone who has an image, can create containers based on the image 
# 1) Share a Docekr file with source code of app ---> simply run docker buuild . ---> IMportant : The DOckerfile instructions might need files/folders
# 2) Share a Built Image ---> Download an image, run a container based on it. ---> no build step everything included on image directly 
# Sharing images via DockerHUb or Private Registry 
# DockerHub one place to share an image or a private registry of your choice
# DocekrHub is simply the oficial DOcker image registry 
# Docker Hub 
# Official DOcekr Image Registry 
# Public, Private and official Images.
# Share: docker push IMAGE_NAME
# Use : docker pull IMAGE_NAME
# We must create a clone of an image locally in our pc 
# we can re tag images with the above mentioned way 
# sudo docker tag goals:latest newname:newtag ---> i create a clone image 
# when you rename an image you do not get rid of the old image , instead you create a clone of the old image
# rename your image and push it to the dockerhub with the appropriate name 
# sudo docker pull .../... --> comes the latest image 