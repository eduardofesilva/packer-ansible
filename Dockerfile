FROM golang:alpine
MAINTAINER "Eduardo Maldonado Fonseca Silva"
ENV PACKER_DEV=1
RUN apk add --update git bash openssl ansible
RUN go get github.com/mitchellh/gox
RUN go get github.com/hashicorp/packer
COPY . .
RUN /bin/bash $GOPATH/src/github.com/hashicorp/packer/scripts/build.sh
ENTRYPOINT ["./entrypoint.sh"]
#ENTRYPOINT ["bin/packer"]