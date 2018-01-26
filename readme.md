
# Build and run a docker image

Build docker images from docker file, goto dockerfile directory and command: 
> docker build -t friendlyserver .

Run docker image from locally built image
> docker run -d -p 50053:8088 friendlyserver   // -d for running it in background //50053:8088 is the exposed port

Connect with docker hub and push to directory, a directory maruftuhin/server_grpc_sample is created  i docker hub at first, then login
> docker login
> docker tag friendlyserver maruftuhin/server_grpc_sample:tag
> docker push maruftuhin/server_grpc_sample

Pull image from docker hub:
> docker pull maruftuhin/server_grpc_sample:tag

Run image using tag , [if locally unavailable, it pulls from online]
> docker run -p -d 4000:8088 maruftuhin/server_grpc_sample:tag

# List of images and containers

List of images
> docker images

List of containers
> docker ps -a   	#-a for all


# Stop/remove a container or image

Stop a container
> docker stop <container_id>

Start a exited container
> docker start <container id>

Remove a image
> docker rmi <image_id>

Remove a container
> docker rm <container id>
> docker rm <container_name>

Remove more than one image/container
> docker rm <container id> <container_id>

# Making change in a container/image

Creates a container for a image and enters it directory
> docker run -it <image_id> /bin/bash

Insert in a existing container [the container must be UP] 
> docker exec -it <container_id> bash
  example: docker exec -it ecf1310ac3ed bash

Anything can be installed in that container, example, at first insert into a container and command:
> apt-get update
> apt-get install fish
> apt-get install php    #installs latest php


Exit container directory
> exit

Creates a image/snapshot of a [may be modified] container
> docker commit <container_id> new_id_of_image


# Executing container commands

Start a exited container
> docker start <container id>

Restart a crashed container
> docker restart <contaienr_id>

Start fish in interactive mode 
> docker exec -it <container_id> fish

Start php inside container 
> docker exec -it <container_id> php -a
> echo "hello world";
> exit


# Names of conatiners or Images

Rename existing container
> docker rename <old_name> new_name


Giving the container a name, while rnning it
> docker run -it --name newName <container_id> bash


# Copy files from a container

Create a text file inside container. insert the container and command:
> touch test.txt

Copy from container. Exit from container and command:
> docker cp containerName:/test.txt .    #copies test.txt to host root

Copy into container
> docker cp ./test1.txt  containerName:/


# Container hostnames

Gives a new hostname to the container. it doesn't change the Names of container. but when user is inside the  container, it sees the hostname, in this case, it's root@test. 
> docker run -it -h test.local <image_id> bash




# Handling volumes

It links between a directory of host and  directory of container. in command, left side of  ":" defines the source of host direcotry and right side defines destination into container.In this case, changing in ~/data of directory of host machine also takes place changing in container automatically

Bind mounts, the pasth is absolute here
> docker run -it --name test21 -v ~/data:/data <image_id> bash



Volume help
> docker volume --help


Inspect a docker container
> docker inspect <container_id>


Named volume [non-bind mount], here the path is not absolute
> docker run -it  -v data:/data <container_id> bash


Used volumes of local machine in container
> docker volume ls


If same volume is used in another container, they will share the volume. 
> docker run -it  -v data:/data <container_id> bash   //shares previous data volume

Remove docker volume, volume_name is available in  docker volume ls
> docker volume rm <volume_name> 

Multiple volume
> docker run -it  -v data:/data  -v myBin:/myBin <container_id> bash

Copy volume from another container
> docker run -it --name slave --volume-from <master_container_id/Name> <image_id> bash

Inspect docker volume
> docker volume inspect <volume_name>

Show danglisg volumes [not used by any container]
> docker volume ls -f dangling=true

Remove one volume that is not used
> docker volume rm <volume name>

Removing all unsed volumes
> docker volume prune

Anonymous volume. --rm will delete anonymous volume after remove container. here /foo is a anonymous volume
> docker run --rm -v /foo -v awesome:/bar busybox top


# Docker killer!!! :P 

Stop all container in one command

> docker stop $(docker ps -a -q)

Delete all container in one command
> docker rm $(docker ps -a -q)

Removing all unsed volumes
> docker volume prune


Remove all images
> docker rmi $(docker images -q)


### Start refresh
#### Dangerous!!! Deletes everything!!
> sudo systemctl stop docker.service
> sudo rm -rf /var/lib/docker
> sudo systemctl start docker.service
