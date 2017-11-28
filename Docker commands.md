#=================[Build and run a docker image]======================

# build docker images from docker file, goto dockerfile directory and command: 
> docker build -t friendlyserver .


# run docker image from locally built image
> docker run -d -p 50053:8088 friendlyserver   // -d for running it in background //50053:8088 is the exposed port

# connect with docker hub and push to directory, a directory maruftuhin/server_grpc_sample is created  i docker hub at first, then login

> docker login
> docker tag friendlyserver maruftuhin/server_grpc_sample:tag
> docker push maruftuhin/server_grpc_sample

# pull image from docker hub:
> docker pull maruftuhin/server_grpc_sample:tag

# run image using tag , [if locally unavailable, it pulls from online]
> docker run -p -d 4000:8088 maruftuhin/server_grpc_sample:tag



#================[List of images and containers]======================



# List of images
> docker images


# list of containers
> docker ps -a   	#-a for all


#==============[ Stop/remove a container or image]=====================

# stop a container
> docker stop <container_id>

# start a exited container
> docker start <container id>


# remove a image
> docker rmi <image_id>

# remove a container
> docker rm <container id>
> docker rm <container_name>

# remove more than one image/container
> docker rm <container id> <container_id>



#=============[Making change in a container/image]=====================


# creates a container for a image and enters it directory
> docker run -it <image_id> /bin/bash


# insert in a existing container [the container must be UP] 
> docker exec -it <container_id> bash
  example: docker exec -it ecf1310ac3ed bash

# anything can be installed in that container, example, at first insert into a container and command:
> apt-get update
> apt-get install fish
> apt-get install php    #installs latest php


# exit container directory
> exit

# creates a image/snapshot of a [may be modified] container
> docker commit <container_id> new_id_of_image


#===================[Executing container commands]====================

# start a exited container
> docker start <container id>

# restart a crashed container
> docker restart <contaienr_id>

# start fish in interactive mode 
> docker exec -it <container_id> fish

# start php inside container 
> docker exec -it <container_id> php -a
> echo "hello world";
> exit


#=============[Names of conatiners or Images]========================

# rename existing container
> docker rename <old_name> new_name


# Giving the container a name, while rnning it
> docker run -it --name newName <container_id> bash


#===========[ Copy files from a container]===========================

# Create a text file inside container. insert the container and command:

> touch test.txt

# copy from container. Exit from container and command:
> docker cp containerName:/test.txt .    #copies test.txt to host root


# copy into container
> docker cp ./test1.txt  containerName:/



#=================[Container hostnames]==============================

# gives a new hostname to the container. it doesn't change the Names of container. but when user is inside the  container, it sees the hostname, in this case, it's root@test. 
> docker run -it -h test.local <image_id> bash




#===================[ Handling volumes]===============================

# it links between a directory of host and  directory of container. in command, left side of  ":" defines the source of host direcotry and right side defines destination into container.In this case, changing in ~/data of directory of host machine also takes place changing in container automatically

#bind mounts, the pasth is absolute here

> docker run -it --name test21 -v ~/data:/data <image_id> bash



# volume help
> docker volume --help


# inspect a docker container
> docker inspect <container_id>


# Named volume [non-bind mount], here the path is not absolute
> docker run -it  -v data:/data <container_id> bash


# used volumes of local machine in container
> docker volume ls


# if same volume is used in another container, they will share the volume. 
> docker run -it  -v data:/data <container_id> bash   //shares previous data volume

# remove docker volume, volume_name is available in  docker volume ls
> docker volume rm <volume_name> 

# multiple volume
> docker run -it  -v data:/data  -v myBin:/myBin <container_id> bash

# copy volume from another container
> docker run -it --name slave --volume-from <master_container_id/Name> <image_id> bash


# inspect docker volume
> docker volume inspect <volume_name>

# Show danglisg volumes [not used by any container]
> docker volume ls -f dangling=true

# remove one volume that is not used
> docker volume rm <volume name>

# Removing all unsed volumes
> docker volume prune

# anonymous volume. --rm will delete anonymous volume after remove container. here /foo is a anonymous volume
> docker run --rm -v /foo -v awesome:/bar busybox top


#====================[ Docker killer!!! :P ]=================================

# stop all container in one command

> docker stop $(docker ps -a -q)

# Delete all container in one command
> docker rm $(docker ps -a -q)

# Removing all unsed volumes
> docker volume prune


# Remove all images
> docker rmi $(docker images -q)


# Start refresh
//Dangerous!!! Deletes everything!!

sudo systemctl stop docker.service
sudo rm -rf /var/lib/docker
sudo systemctl start docker.service