FROM debian:buster
MAINTAINER jdussert <jdussert@student.42.fr>

RUN apt-get update -y \
apt-get upgrade -y \
&& apt-get -y install nginx \ # NGINX
&& apt-get -y install mariadb-server \ # MySQL
&& apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring \ # Php
&& apt-get -y install wget \ # Tools
&& apt-get clean -y

ADD ./srcs/wordpress_config.php
WORKDIR /srcs
RUN npm install

EXPOSE 2368
VOLUME /srcs

CMD npm run start