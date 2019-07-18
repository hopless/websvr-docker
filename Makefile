
build:
	docker-compose up -d
stop:
	docker stop ajil
rm:
	docker rm ajil
rf:
	docker stop ajil && docker rm ajil
