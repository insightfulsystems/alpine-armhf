FROM       scratch
MAINTAINER Rui Carmo https://github.com/rcarmo

ADD ./rootfs.tar.xz /

RUN apk update && apk upgrade && apk add ca-certificates curl wget && rm -rf /var/cache/apk/*

CMD ["/bin/sh"]
