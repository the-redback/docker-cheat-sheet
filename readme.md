# Docker Cheat Sheet

## Build and run a docker image

Build docker images from docker file, goto dockerfile directory and command: 

```console
$ docker build -t friendlynginx .
```

Run docker image from locally built image

```console
$ docker run -d -p 50053:8088 friendlynginx
# -d for running it in background //50053:8088 is the exposed port
```

Connect with docker hub and push to directory, a directory maruftuhin/nginx is created  i docker hub at first, then login

```console
$ docker login
$ docker tag friendlynginx maruftuhin/nginx:tag
$ docker push maruftuhin/nginx
```

Pull image from docker hub:

```console
$ docker pull maruftuhin/nginx:tag
```

Run image using tag , [if locally unavailable, it pulls from online]

```console
$ docker run -p -d 4000:8088 maruftuhin/nginx:tag
```

## List of images and containers

List of images

```console
$ docker images
```

List of containers

```console
$ docker ps -a
# -a for all
```

## Stop/remove a container or image

Stop a container

```console
$ docker stop <container_id>
```

Start a exited container

```console
$ docker start <container id>
```

Remove an image

```console
$ docker rmi <image_id>
```

Remove a container

```console
$ docker rm <container id>
$ docker rm <container_name>
```

Remove more than one image/container

```console
$ docker rm <container id> <container_id>
```

## Making change in a container/image

Creates a container for a image and enters it directory

```console
$ docker run -it <image_id> /bin/bash
```

Insert in a existing container [the container must be UP]

```console
$ docker exec -it <container_id> bash
# example: docker exec -it ecf1310ac3ed bash
```

Anything can be installed in that container, example, at first insert into a container and command:

```console
$ apt-get update
$ apt-get install fish
$ apt-get install php    #installs latest php
```

Exit container directory

```console
$ exit
```

Creates a image/snapshot of a [may be modified] container

```console
$ docker commit <container_id> new_id_of_image
```

## Executing container commands

Start a exited container

```console
$ docker start <container id>
```

Restart a crashed container

```console
$ docker restart <contaienr_id>
```

Start fish in interactive mode

```console
$ docker exec -it <container_id> fish
```

Start php inside container

```console
$ docker exec -it <container_id> php -a
$ echo "hello world";
$ exit
```

## Names of conatiners or Images

Rename existing container

```console
$ docker rename <old_name> new_name
```

Giving the container a name, while rnning it

```console
$ docker run -it --name newName <container_id> bash
```

## Copy files from a container

Create a text file inside container. insert the container and command:

```console
$ touch test.txt
```

Copy from container. Exit from container and command:

```console
$ docker cp containerName:/test.txt .    #copies test.txt to host root
```

Copy into container

```console
$ docker cp ./test1.txt  containerName:/
```

## Container hostnames

Gives a new hostname to the container. it doesn't change the Names of container. but when user is inside the  container, it sees the hostname, in this case, it's root@test.

```console
$ docker run -it -h test.local <image_id> bash
```

## Handling volumes

It links between a directory of host and  directory of container. in command, left side of  ":" defines the source of host direcotry and right side defines destination into container.In this case, changing in ~/data of directory of host machine also takes place changing in container automatically

Bind mounts, the pasth is absolute here

```console
$ docker run -it --name test21 -v ~/data:/data <image_id> bash
```

Volume help

```console
$ docker volume --help
```

Inspect a docker container

```console
$ docker inspect <container_id>
```

Named volume [non-bind mount], here the path is not absolute

```console
$ docker run -it  -v data:/data <container_id> bash
```

Used volumes of local machine in container

```console
$ docker volume ls
```

If same volume is used in another container, they will share the volume.

```console
$ docker run -it  -v data:/data <container_id> bash   //shares previous data volume
```

Remove docker volume, volume_name is available in  docker volume ls

```console
$ docker volume rm <volume_name>
```

Multiple volume

```console
$ docker run -it  -v data:/data  -v myBin:/myBin <container_id> bash
```

Copy volume from another container

```console
$ docker run -it --name slave --volume-from <master_container_id/Name> <image_id> bash
```

Inspect docker volume

```console
$ docker volume inspect <volume_name>
```

Show danglisg volumes [not used by any container]

```console
$ docker volume ls -f dangling=true
```

Remove one volume that is not used

```console
$ docker volume rm <volume name>
```

Removing all unsed volumes

```console
$ docker volume prune
```

Anonymous volume. --rm will delete anonymous volume after remove container. here /foo is a anonymous volume

```console
$ docker run --rm -v /foo -v awesome:/bar busybox top
```

## UnTagged Images <none>:<none>

Show untagged images

```console
$ docker images -f "dangling=true" -q
```

Delete all untagged images

```console
 $ docker rmi $(docker images -f "dangling=true" -q)
```

## Delete multiple images

Delete images of same name

```console
$ docker rmi $(docker images --format '{{.Repository}}:{{.Tag}}' | grep 'imagename')

# or
$ docker rmi --force $(docker images -q imagename | uniq)
```

## Docker killer!!! :P

Stop all container

```console
$ docker stop $(docker ps -a -q)
```

Delete all container

```console
$ docker rm $(docker ps -a -q)
```

Removing all unused volumes

```console
$ docker volume prune
```

Remove untagged dockers

```console
$ docker rmi $(docker images -f "dangling=true" -q)
```

Remove all images

```console
$ docker rmi $(docker images -q)
```

## Start fresh

### Dangerous!!! Deletes everything!!

```console
$ sudo systemctl stop docker.service
$ sudo rm -rf /var/lib/docker
$ sudo systemctl start docker.service
```

## Copy Local images to Minikube

For bash

```console
$ docker save <image-name> | pv | (eval $(minikube docker-env) && docker load)

Or,
$ docker save <image-name> | (eval $(minikube docker-env) && docker load)
```
