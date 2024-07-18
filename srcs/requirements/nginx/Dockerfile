# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: damachad <damachad@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/09 10:16:36 by damachad          #+#    #+#              #
#    Updated: 2024/07/17 16:00:35 by damachad         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt -y update && apt install -y \
	nginx \
	openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-out /etc/ssl/nginx-selfsigned.pem \
	-keyout /etc/ssl/nginx-selfsigned.key \
	-subj "/C=PT/ST=Porto/L=Porto/O=42/OU=42/CN=${DOMAIN_NAME}/UID=${DB_USER}"

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE	443

ENTRYPOINT ["nginx", "-g", "daemon off;"]