FROM archlinux:latest

COPY ./docker/mirrorlist /etc/pacman.d/mirrorlist

RUN pacman-db-upgrade

RUN pacman -Syyu --noconfirm npm nodejs

COPY . /var/api/bot-api
WORKDIR /var/api/bot-api


RUN npm install


ARG values_script

RUN /bin/bash install/install.sh "${values_script}"


EXPOSE 6767


CMD [ "node", "api.js" ]
