Image utilisée comme base de notre image :
FROM debian:9
USER jdussert@student.42.fr

Commandes à effectuer dans notre conteneur
RUN apt-get update -yq \
&& apt-get install curl gnupg -yq \
&& curl -sL https://deb.nodesource.com/setup_10.x | bash \
&& apt-get install nodejs -yq \
&& apt-get clean -y

Copier contenu depuis machine vers image docker en cours de construction
ADD . /srcs/

Specifier notre repertoire courant pour la suite
WORKDIR /srcs

Définir la commande lancée par conteneur lors de son execution
CMD npm run start