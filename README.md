# Docker bpm-tools

## Description

This repository contains the Dockerfile to build a docker image of
[bpm-tools](http://www.pogo.org.uk/~mark/bpm-tools/).


## Registry

A pre-built docker image is available on
[Dockerhub](https://hub.docker.com/r/wichtf/bpm-tools).

## Instructions

### Command

To run bpm-tools with the pre-built image, simply run the following
command.

```shell 
docker run -d --name bpm-tools -e PUID=1000 -e PGID=1000 -e INTERVAL=1000 -e TZ=Europe/Berlin -v <you_music_dir>:/music
```

### Compose

To run bpm-tools with docker-compose, here is a sample compose
file.

```yaml

version: '3.2'
services:
  bpm-tools:
    image: wichtf/bpm-tools:latest
    container_name: bpm-tools
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Berlin
      - INTERVAL=1000
    volumes:
      - ./music:/music 

```

To start the container once the compose file written to disk, run
the following command.

```shell 

docker-compose up -d

```


      
