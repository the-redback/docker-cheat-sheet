#This is a sample Image
FROM ubuntu

RUN apt update
RUN apt install -y nginx
CMD [“echo”,”Image created”]
