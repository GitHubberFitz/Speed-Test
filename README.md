[<img src="https://img.shields.io/badge/dockerhub-Repo_Image-Important.svg?logo=Docker">](https://hub.docker.com/r/fitzdockerhub/openspeedtest)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/fitzdockerhub/openspeedtest)

# Speed-Test
A docker image for the [Speed Test by OpenSpeedTest™](https://github.com/openspeedtest/Speed-Test) project.

## About:

This container serves NTPsec and gpsd, built on the Docker Alpine image.

This container serves [Speed Test by OpenSpeedTest](https://github.com/openspeedtest/Speed-Test), built on the Docker [nginx](https://hub.docker.com/_/nginx) image.

# Usage
## Pull the image
```
docker pull fitzdockerhub/openspeedtest:latest
```

## Run
Webserver will be started on port 80
```
docker run -d \
    --restart unless-stopped \
    --name speed-test \
    -p 80:80 \
fitzdockerhub/openspeedtest:latest
```
## Example
![](https://github.com/openspeedtest/v2-Test/raw/main/images/10G-S.gif)
