<<<<<<< HEAD
export RELEASE?=3.5
build: Dockerfile rootfs.tar.xz
	docker build -t rcarmo/alpine:${RELEASE}-armhf .

rootfs.tar.xz:
	sh ./mkrootfs.sh -s -r v${RELEASE}

tag:
	docker tag rcarmo/alpine:armhf rcarmo/alpine:${RELEASE}-armhf
=======
build: Dockerfile
	docker build -t rcarmo/alpine:armhf .

tag:
	docker tag rcarmo/alpine:armhf rcarmo/alpine:3.4-armhf
>>>>>>> 77031c75d3744c1360cce724a0efe836cd04ca60

push:
	docker push rcarmo/alpine
