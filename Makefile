export RELEASE?=3.5
armhf: Dockerfile rootfs.armhf.tar.xz
	mv rootfs.armhf.tar.xz rootfs.tar.xz
	docker build -t rcarmo/alpine:armhf .
	docker tag rcarmo/alpine:armhf rcarmo/alpine:${RELEASE}-armhf

x86_64: Dockerfile rootfs.x86_64.tar.xz
	mv rootfs.x86_64.tar.xz rootfs.tar.xz
	docker build -t rcarmo/alpine:x86_64 .
	docker tag rcarmo/alpine:x86_64 rcarmo/alpine:${RELEASE}-x86_64

rootfs.armhf.tar.xz:
	ARCH=armhf sh ./mkrootfs.sh -s -r v${RELEASE}
	mv rootfs.tar.xz rootfs.armhf.tar.xz

rootfs.x86_64.tar.xz:
	ARCH=x86_64 sh ./mkrootfs.sh -s -r v${RELEASE}
	mv rootfs.tar.xz rootfs.x86_64.tar.xz

push:
	docker push rcarmo/alpine
