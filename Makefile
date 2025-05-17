all: Volumes build up

Volumes:
	bash ./srcs/volumes.sh

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

clean:
	docker system prune -af
	sudo rm -rf ~/MyDatabase

volumes_clean:
	sudo rm -rf ~/MyDatabase ~/logs

re: clean all
