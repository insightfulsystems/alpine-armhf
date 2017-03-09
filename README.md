<<<<<<< HEAD
# docker-alpine-armhf
=======
# alpine-arm
>>>>>>> 77031c75d3744c1360cce724a0efe836cd04ca60

This is a minimal, busybox-like [Alpine Linux](http://alpinelinux.org/) container, 

It contains a bare minimum of packages required for building containers:

- `apk`
- `curl`
- `wget`
- `ca-certificates`

## Credits

This is a fork of [`luxas/alpine-arm`](https://github.com/luxas/alpine-arm), which was in turn possible thanks to work by [`uggedal`](https://github.com/uggedal) on packaging [Alpine Linux for Docker](https://github.com/uggedal/docker-alpine).

## Changes

<<<<<<< HEAD
* Removed the additional install script (for feature parity with other images) and simplified the `Dockerfile` somewhat.
* Removed pointless nested build step and bumped version
=======
Removed the additional install script (for feature parity with other images) and simplified the `Dockerfile` somewhat.
>>>>>>> 77031c75d3744c1360cce724a0efe836cd04ca60

## Usage

Use this as base for your own containers:

```dockerfile
<<<<<<< HEAD
FROM rcarmo/alpine:3.5-armhf
=======
FROM rcarmo/alpine:3.4-armhf
>>>>>>> 77031c75d3744c1360cce724a0efe836cd04ca60
RUN apk-install <packagename>

CMD ["/bin/sh"]
```
