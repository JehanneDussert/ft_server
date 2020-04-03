FROM debian:buster
LABEL maintainer ="jdussert@student.42.fr"

WORKDIR /srcs

RUN apt-get update -y && apt-get upgrade -y

# Tools
RUN apt-get -y install wget

# NGINX
RUN apt-get -y install nginx

# PHP
RUN apt-get install -y php php-fpm php-gd php-mysql php-cli php-curl php-json
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-english.tar.gz \
    && mkdir /var/www/html/phpmyadmin \
    && tar xzf phpMyAdmin-4.9.0.1-english.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin

# MySQL
RUN apt-get -y install mariadb-server

# WORDPRESS
ADD /srcs/wp_config /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/wp_config /etc/nginx/sites-enabled/ && \
    rm -f /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default && \
    wget https://wordpress.org/latest.tar.gz -P /tmp && \
    mkdir /var/www/html/wordpress && \
    tar xzf /tmp/latest.tar.gz --strip-components=1 -C /var/www/html/wordpress
ADD /srcs/wordpress_config.php /var/www/html/wordpress
RUN chown -R www-data:www-data /var/www/html/wordpress

ADD /srcs/init.sh .
ENTRYPOINT ["/bin/sh", "init.sh"]
#RUN apt-get clean -y

#RUN npm install

#EXPOSE 2368
#VOLUME /var/wwww/html

#CMD npm run start