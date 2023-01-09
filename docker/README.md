# Speed-Test
A docker image for the [Speed Test by OpenSpeedTest](https://github.com/openspeedtest/Speed-Test) project.

Documentation and build located at:
     https://github.com/GitHubberFitz/Speed-Test

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
![](https://github.com/GitHubberFitz/Speed-Test/raw/main/ost/10G-S.gif)
