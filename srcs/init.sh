service mysql start
mysql -e "
CREATE DATABASE wordpress;
CREATE USER 'wordpress_user'@'localhost' IDENTIFIED BY '0000';
GRANT ALL ON wordpress.* TO 'wordpress_user'@'localhost' IDENTIFIED BY '0000' WITH GRANT OPTION;
FLUSH PRIVILEGES;"
service nginx start
service php7.3-fpm start
tail -f /dev/null