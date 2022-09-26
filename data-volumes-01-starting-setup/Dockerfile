FROM node:14

WORKDIR /app

# copy package.json in the working directory .dot
COPY package.json .

RUN npm install 

# first dot refers to the entire folder here and second . refers to the /app directory 
# ont time snapshot which is copied into the image 
COPY . .

EXPOSE 80

# With this instruction we add an anonymous volume to the image 
# THere are also Named Volumes 
# On both cases Docker set up a folder/path on your host machine, 
# exact location is uknown to you. Managed via docker volume commands.
# with docker volume ls ---> we get all volumes managed by this container 
# anonymous volume exists only as container exists 
VOLUME [ "/app/feedback" ]

# command which i want to execute when a container is started based on this image 
CMD ["node", "server.js"]


# We create an image based on Dcker file with the below mentioned command 
# sudo docker build -t feedback-node:latest 
# We start container with the below mentioned command 
# sudo docker run -p 3000:80 -d --name feedback-app --rm feedback-node
# Container layer is able to write inside of image file system , it has its own copy of that you could say 
# if a container only stops then files does not lose
# if a container remove then files is cleared at all.
# if we delete container all files which write inside there are lost because is read-write operation and we have only the image layer then 
# Multiple containers based on the same image are totally isolated , and in many application that is a problem 
# let's say we want to have these files even if container is deleted 
# or we might dealing with user data and with product data submitted by user 
# Volumes help us with persisting data, 
# Volumes are folders on your host machine hard drive which are mounted("made available",mapped) into containers 
# Not on your container not on your image but in your host machine hard drive which are mounted 
# which meand made it available or mapped into containers 
# So volumes are fodlers on your host-machine, on your computer , 
# Which make docker aware of and then mapped to folders inside of Docker container 
# With Volume you can copy a folder outside of the container, on your host-machine 
# and changes in a folder will be reflected into another one 
# So if you add a file on your host machine , it is accessible inside of a container and the reversed
# Volumes persist if a container shuts down. If a container (re-)starts and mounts a volume, any data inside of that volume is available in the container
# if you add a volum in acontainer the volume will not removed when the container removed it survices and data in VOlumes survives 
# A container can read data into a volume and write data from it 
# With Docker we have multiple data storage mechanisms 
# 1) Volumes (Managed By Docker)
# 2) Bind Mounts (Managed by u)
# A defined path in the container is mapped to the created volume/mount.
# e.g /some-path on your host-machine is mapped to /app/data
# if the volume does not deleted even if the container is deleted that's the case where local-machine folder would survice 
# Named volumes should be great for data which should be persistent.
# We can not create named volumes inside of a Dockerfile 
# we create a named volume when we start a container 
# sudo docker run -d -p 3000:80 --rm --name feedback-app -v feedback:/app/feedback feedback-node:volumes
# create a named volume inside of container and will not been deleted when the container shuts down 
# named volumes are not attached to a container
# if i create a new container with same volume name the data will be still there with the help of named volumes 
# you can delete all anonymous volumes with the following command docker volume prune 

