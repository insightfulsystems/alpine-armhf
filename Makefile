export RELEASE?=3.12

.PHONY: armhf amd64 rootfs.armhf rootfs.amd64

rootfs.armhf:
	docker build -t base-rootfs .
	docker run --name build-rootfs -it base-rootfs -r v${RELEASE}
	docker cp build-rootfs:/tmp/rootfs.tar.xz .
	docker rm build-rootfs
	mv rootfs.tar.xz armhf/

rootfs.amd64:
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
