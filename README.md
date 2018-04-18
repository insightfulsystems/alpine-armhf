# alpine-armhf

[![Build Status](https://travis-ci.org/insightfulsystems/docker-alpine.svg?branch=master)](https://travis-ci.org/insightfulsystems/docker-alpine)


This is a minimal, busybox-like [Alpine Linux](http://alpinelinux.org/) container, 

It contains a bare minimum of packages required for building containers:

- `apk`
- `curl`
- `wget`
- `ca-certificates`

## Credits

This is a fork of [`luxas/alpine-arm`](https://github.com/luxas/alpine-arm), which was in turn possible thanks to work by [`uggedal`](https://github.com/uggedal) on packaging [Alpine Linux for Docker](https://github.com/uggedal/docker-alpine).

## Changes

* Removed the additional install script (for feature parity with other images) and simplified the `Dockerfile` somewhat.
* Removed pointless nested build step and bumped version

## Usage

Use this as base for your own containers:

```dockerfile
FROM insightful/alpine:3.7-armhf
RUN apk-install <packagename>

CMD ["/bin/sh"]
```
