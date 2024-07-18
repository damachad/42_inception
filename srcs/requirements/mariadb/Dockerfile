# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: damachad <damachad@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/09 10:16:28 by damachad          #+#    #+#              #
#    Updated: 2024/07/17 16:00:10 by damachad         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt update && apt install -y \
	mariadb-server

COPY ./conf/mdb_conf.sh /mdb_conf.sh

RUN chmod +x /mdb_conf.sh

EXPOSE 3306

ENTRYPOINT ["./mdb_conf.sh"]