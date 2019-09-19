FROM node:slim

RUN apt update
RUN apt-get install -y -qq git && apt-get -y install jq
WORKDIR /usr/src/
ENTRYPOINT [ "/bin/bash"]