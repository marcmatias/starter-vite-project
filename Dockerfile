FROM node:20-alpine

# /bin/sh sucks, so we use bash instead
RUN apk update && apk add bash

# Update npm to the latest version
RUN npm install -g npm@^10.2.0

WORKDIR /srv/app
COPY package* /srv/app/
RUN cd /srv/app && npm install
#COPY . /srv/app/
