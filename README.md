
[<img src="https://img.shields.io/badge/dockerhub-Repo_Image-Important.svg?logo=Docker">](https://hub.docker.com/r/fitzdockerhub/openspeedtest)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/fitzdockerhub/openspeedtest)

# Speed-Test
A docker image for the [Speed Test by OpenSpeedTest™](https://github.com/openspeedtest/Speed-Test) project.

## About:

This container runs NTPsec and gpsd, built on the Docker Alpine image.

#  - Install -
The following will pull down the image and start the webserver on port 80
```
docker run -d \
    --restart unless-stopped \
    --name speed-test \
    -p 80:80 \
fitzdockerhub/openspeedtest:latest
```
