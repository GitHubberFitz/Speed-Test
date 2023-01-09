FROM nginx:latest
ARG BUILD_DATE
ARG BUILD_VERSION

### About this container
LABEL DOCKER_REPO="fitzdockerhub/openspeedtest"
LABEL BUILD_DATE="${BUILD_DATE}"
LABEL MAINTAINER="https://github.com/GitHubberFitz"
LABEL DOCUMENTATION="https://github.com/GitHubberFitz/openspeedtest"
LABEL OpenSpeedTest_VERSION="${BUILD_VERSION}"

### Remove initial httpd files
RUN rm -f /usr/share/nginx/html/*

### Move the files we only need
COPY ost/index.html /usr/share/nginx/html
COPY ost/hosted.html /usr/share/nginx/html
COPY ost/downloading /usr/share/nginx/html
COPY ost/upload /usr/share/nginx/html
COPY ost/License.md /usr/share/nginx/html
COPY ost/assets /usr/share/nginx/html

### Ports
EXPOSE 80/tcp

### Monitor HTTP process
#HEALTHCHECK CMD nginx || exit 1

### Start
#ENTRYPOINT ["/docker-entrypoint.sh"]

#STOPSIGNAL SIGQUIT
#CMD ["nginx", "-g", "daemon off;"]