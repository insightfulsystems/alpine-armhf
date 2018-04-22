export RELEASE?=3.7

.PHONY: armhf amd64 

rootfs.armhf.tar.xz:
	ARCH=armhf sudo -E sh ./mkrootfs.sh -s -r v${RELEASE}
	mv rootfs.tar.xz armhf/

rootfs.amd64.tar.xz:
	ARCH=x86_64 sudo -E sh ./mkrootfs.sh -s -r v${RELEASE}
	mv rootfs.tar.xz amd64/

armhf:
	docker build -t insightful/alpine:${RELEASE}-armhf armhf

amd64:
	docker build -t insightful/alpine:${RELEASE}-amd64 amd64


manifest:
	docker manifest create insightful/alpine:${RELEASE}
	docker manifest annotate insightful/alpine:${RELEASE} insightful/alpine:${RELEASE}-armhf --os linux --arch arm --variant v7
	docker manifest annotate insightful/alpine:${RELEASE} insightful/alpine:${RELEASE}-amd64 --os linux --arch amd64

push:
	docker push insightful/alpine
