
.docker_start:
	systemctl is-active docker.service || systemctl start docker.service

test_build: .docker_start
	docker-compose build

test_run: test_build
	docker-compose up

test_init: test_run



