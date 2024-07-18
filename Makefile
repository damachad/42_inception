# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: damachad <damachad@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/09 10:15:29 by damachad          #+#    #+#              #
#    Updated: 2024/07/10 15:53:40 by damachad         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

WP_DATA = /home/damachad/data/wordpress/
DB_DATA = /home/damachad/data/mariadb/
DOMAIN_NAME = login.42.fr

all: up

# start the building process
# create the wordpress and mariadb data directories.
# start the containers in the background and leaves them running
up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	@sudo hostsed add 127.0.0.1 $(DOMAIN_NAME)
	@docker compose -f ./srcs/docker-compose.yml up -d

down:
	@docker compose -f ./srcs/docker-compose.yml down

build:
	@docker compose -f ./srcs/docker-compose.yml build

# stop all running containers and remove them.
# remove all images, volumes and networks.
# remove the wordpress and mariadb data directories.
clean: down
	@echo "REMOVING IMAGES"
	@docker rmi -f $$(docker images -qa)
	@echo "REMOVING VOLUMES"
	@docker volume rm $$(docker volume ls -q)
	@sudo rm -rf $(WP_DATA)
	@sudo rm -rf $(DB_DATA)
	@sudo hostsed rm 127.0.0.1 $(DOMAIN_NAME)

re: clean up
	
# remove all unused containers, networks and images from the system
prune:
	docker system prune -a

status:
	@clear
	@docker ps -a
	@echo ""
	@docker image ls
	@echo ""
	@docker volume ls
	@echo ""
	@docker network ls
	@echo ""
	
.PHONY: all up down build clean re
