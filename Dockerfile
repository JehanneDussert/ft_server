FROM debian:buster
LABEL maintainer ="jdussert@student.42.fr"

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y php php-fpm php-gd php-mysql php-cli php-curl php-json
RUN tar -zxvf wordpress_FR.tar.gz
RUN apt-get -y install nginx # NGINX
RUN apt-get -y install mariadb-server # MySQL
RUN apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring # Php
RUN apt-get -y install wget # Tools
RUN apt-get clean -y

ADD . /srcs/wordpress_config.php
WORKDIR /srcs
RUN npm install

EXPOSE 2368
VOLUME /srcs

CMD npm run start
