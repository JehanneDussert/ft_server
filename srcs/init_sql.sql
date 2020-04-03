CREATE DATABASE wordpress;
CREATE USER 'wordpress_user'@'localhost' IDENTIFIED BY '0000'
GRANT ALL ON wordpress.* TO 'wordpress_user'@'localhost' IDENTIFIED BY '0000' WITH GRANT OPTION;
FLUSH PRIVILEGES;