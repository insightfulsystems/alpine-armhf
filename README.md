# alpine-arm

This is a minimal, busybox-like [Alpine Linux](http://alpinelinux.org/) container, 

It contains a bare minimum of packages required for building containers:

- `[apk](http://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management)`
- `curl`
- `wget`
- `ca-certificates`

## Credits

This is a fork of `[luxas/alpine-arm](https://github.com/luxas/alpine-arm)`, which was in turn possible thanks to work by `[uggedal](https://github.com/uggedal)` on packaging [Alpine Linux for Docker](https://github.com/uggedal/docker-alpine).

## Changes

Removed the additional install script (for feature parity with other images) and simplified the `Dockerfile` somewhat.

## Usage

Use this as base for your own containers:

```dockerfile
FROM rcarmo/alpine:3.4-armhf
RUN apk-install <packagename>

CMD ["/bin/sh"]
```
