FROM debian:buster
LABEL maintainer ="jdussert@student.42.fr"

WORKDIR /tmp

# Install update
RUN apt-get update -y && apt-get upgrade -y

# Install wget
RUN apt-get -y install wget

# Install nginx
RUN apt-get -y install nginx

# Install php + extensions
RUN apt-get install -y php php-fpm php-gd php-mysql php-cli php-curl php-json
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-english.tar.gz \
    && mkdir /var/www/html/phpmyadmin \
    && tar xzf phpMyAdmin-4.9.0.1-english.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin

# Key and certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=FR/ST=75/L=Paris/O=42/CN=jdussert" \
	-keyout /tmp/server.key \
	-out /tmp/server.crt

# MySQL
RUN apt-get -y install mariadb-server

# Nginx config + install wp
ADD /srcs/nginx_config /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/nginx_config /etc/nginx/sites-enabled/ && \
    rm -f /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default && \
    wget https://wordpress.org/latest.tar.gz -P /tmp && \
    mkdir /var/www/html/wordpress && \
    tar xzf /tmp/latest.tar.gz --strip-components=1 -C /var/www/html/wordpress
ADD /srcs/wordpress_config.php /var/www/html/wordpress
RUN chown -R www-data:www-data /var/www/html/wordpress

ADD /srcs/init.sh .
ENTRYPOINT ["/bin/sh", "init.sh"]
