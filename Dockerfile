FROM  resin/rpi-raspbian
MAINTAINER Rui Carmo https://github.com/rcarmo

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
  apt-get install -y \
    curl \
    tar \
    xz-utils \
    && \
  apt-get clean autoclean && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/

ADD ./mkrootfs.sh /mkrootfs.sh

ENTRYPOINT ["/mkrootfs.sh"]
CMD ["-h"]