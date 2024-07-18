# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: damachad <damachad@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/09 10:16:36 by damachad          #+#    #+#              #
#    Updated: 2024/07/10 17:49:33 by damachad         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt -y update && apt install -y \
	curl \
	mariadb-client \
	netcat \
	php \
	php-mysql \
	php7.4-fpm

COPY ./conf/wp_conf.sh /

RUN  chmod +x wp_conf.sh

RUN mkdir -p /var/www/wordpress

EXPOSE 9000

ENTRYPOINT ["./wp_conf.sh"]