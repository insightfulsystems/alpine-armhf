export RELEASE?=3.7

.PHONY: armhf amd64 

rootfs.armhf.tar.xz:
	ARCH=armhf sudo -E sh ./mkrootfs.sh -s -r v${RELEASE}
	mv rootfs.tar.xz rootfs.armhf.tar.xz

rootfs.amd64.tar.xz:
	ARCH=x86_64 sudo -E sh ./mkrootfs.sh -s -r v${RELEASE}
	mv rootfs.tar.xz rootfs.amd64.tar.xz

armhf: Dockerfile rootfs.armhf.tar.xz
	mv rootfs.armhf.tar.xz rootfs.tar.xz
	docker build -t insightful/alpine:${RELEASE}-armhf armhf

amd64: Dockerfile rootfs.amd64.tar.xz
	mv rootfs.amd64.tar.xz rootfs.tar.xz
	docker build -t insightful/alpine:${RELEASE}-amd64 amd64


manifest:
	docker manifest create insightful/alpine:${RELEASE}
	docker manifest annotate insightful/alpine:${RELEASE} insightful/alpine:${RELEASE}-armhf --os linux --arch arm --variant v7
	docker manifest annotate insightful/alpine:${RELEASE} insightful/alpine:${RELEASE}-amd64 --os linux --arch amd64

push:
	docker push insightful/alpine
