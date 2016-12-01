build: Dockerfile
	docker build -t rcarmo/alpine:armhf .

tag:
	docker tag rcarmo/alpine:armhf rcarmo/alpine:3.4-armhf

push:
	docker push rcarmo/alpine
