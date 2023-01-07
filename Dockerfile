FROM ngnix:latest
ARG BUILD_DATE

### About this container
LABEL build_info="fitzdockerhub/openspeedtest build-date:- ${BUILD_DATE}"
LABEL maintainer="Fitz <https://github.com/GitHubberFitz>"
LABEL documentation="https://github.com/GitHubberFitz/openspeedtest"



### Monitor HTTP process
HEALTHCHECK CMD nginx || exit 1