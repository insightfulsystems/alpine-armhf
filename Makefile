export RELEASE?=3.5
build: Dockerfile rootfs.tar.xz
	docker build -t rcarmo/alpine:armhf .

rootfs.tar.xz:
	sh ./mkrootfs.sh -s -r v${RELEASE}

tag:
	docker tag rcarmo/alpine:armhf rcarmo/alpine:${RELEASE}-armhf

push:
	docker push rcarmo/alpine:armhf
