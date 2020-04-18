FROM golang:alpine
MAINTAINER "Eduardo Maldonado Fonseca Silva"

ENV PACKER_DEV=1

RUN apk add --update git bash openssl ansible

RUN go get github.com/mitchellh/gox
RUN go get github.com/hashicorp/packer

WORKDIR $GOPATH/src/github.com/hashicorp/packer

COPY . $GOPATH

RUN /bin/bash scripts/build.sh

WORKDIR $GOPATH
ENTRYPOINT ["/entrypoint.sh"]
#ENTRYPOINT ["bin/packer"]