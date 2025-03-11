all: build up

build:
	bash ./srcs/volumes.sh
	docker-compose build

up:
	bash ./srcs/volumes.sh
	docker-compose up -d

down:
	docker-compose down
clean:
	docker system prune -af

fclean: down
	docker-compose down --rmi local

re: clean all
