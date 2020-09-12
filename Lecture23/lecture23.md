# Lecture 23

## Containerize our backend app

## What happens when we haves more servers?
- We need to copy the exact setup to new servers
- Problems
  - 1. Tedious and takes a long time
  - 2. Easy to make a mistake to mess up with the environment/dependencies
  - 3. In a different OS environment the same steps might not work anymore (WIndows vs. Linux)

## What is containerization?
  - <img src="./container.png" height=400>
  - **Container**: a lightweight package that contains application and its dependencies
    - Can easily port one container image to another OS environment and that will work fine
  - **Container image**: container at runtime


## Docker technology
- https://www.docker.com/


## Install Docker in AWS Linux 2
1. `sudo yum update`
2. `sudo amazon-linux-extras install docker`
3. `sudo usermod -a -G docker ec2-user`
4. Run `docker` see if it works

## Steps
1. Generate requirements.txt
2. Create a dockerfile
```
from ubuntu:18.04

# Install dependencies
# -y means answer yes to installations
RUN apt-get update && \
 apt-get -y install apache2

# Install python
RUN apt install -y python3-pip
RUN apt install -y python3-venv
RUN pip3 install --upgrade pip

# Setup code directory inside the container
COPY . /flask_app
WORKDIR /flask_app

# Install flask dependencies
RUN pip3 install -r requirements.txt

# Environment variables
ENV FLASK_APP=app
ENV FLASK_ENV=development
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
```
3. Run `docker build -t app:latest .`
   - Build up a container image to be used
4. Run `docker run -p 5000:5000 -it app`
   - Start running a container image

## Why is it not working
- Because `127.0.0.1` is localhost, which means it's hosting on top of docker container's IP address
- We need to use `flask run --host 0.0.0.0`
  - `0.0.0.0` allows it to be on top of any of the IP addresses available, so both Docker and the machine's 

## Redis error
- In order to setup two docker containers, we need to use `docker-compose` instead
- https://docs.docker.com/compose/
  - Basically it is a tool for running multiple containers
- Tutorial
  - https://docs.docker.com/compose/gettingstarted/
- The new docker file
```
from python:3.7-alpine

WORKDIR /code

ENV FLASK_APP app.py
ENV FLASK_RUN_HOST 0.0.0.0

RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
EXPOSE 5000
COPY . .
CMD ["flask", "run"]
```
- Docker compose file
```
version: '3'
services:
  server:
    build: .
    ports:
      - "5000:5000"
  redis:
    image: "redis:alpine"
```

## Now what happened?
- No access to dynamodb table
- Because no AWS credentials
- We need to pass the AWS credentials in as an environment variable
- Add the following to Dockerfile
```
ENV AWS_ACCESS_KEY_ID=XXX
ENV AWS_SECRET_ACCESS_KEY=XXX
```
