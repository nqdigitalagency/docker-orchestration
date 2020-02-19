ARG TARGET_PHP_VERSION=7.3
FROM php:${TARGET_PHP_VERSION}-fpm

ARG SERVICE_DIR="./.docker/php-fpm"
COPY ./.docker/.shared/scripts/ /tmp/scripts/
RUN chmod +x -R /tmp/scripts/

# set timezone
ARG TZ=UTC
RUN /tmp/scripts/set_timezone.sh ${TZ}

# add users
ARG APP_USER=www-data
ARG APP_GROUP=www-data
ARG APP_USER_ID=1000
ARG APP_GROUP_ID=1000

RUN /tmp/scripts/create_user.sh ${APP_USER} ${APP_GROUP} ${APP_USER_ID} ${APP_GROUP_ID}

RUN /tmp/scripts/install_php_extensions.sh

RUN /tmp/scripts/install_software.sh

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Phalcon
#ARG PHALCON_VERSION=v3.4.5
#WORKDIR /usr/local/src
#RUN git clone https://github.com/phalcon/cphalcon.git --branch "$PHALCON_VERSION" --single-branch
#WORKDIR /usr/local/src/cphalcon/build
#RUN ./install

# Install wkhtmltopdf
RUN apt-get -yqq install fontconfig libxrender1 xfonts-75dpi xfonts-base
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb
RUN dpkg -i wkhtmltox_0.12.5-1.buster_amd64.deb
RUN rm wkhtmltox_0.12.5-1.buster_amd64.deb

# Install Microsoft fonts
RUN apt-get install -yqq cabextract
RUN wget http://ftp.es.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.7_all.deb
RUN dpkg -i ttf-mscorefonts-installer_3.7_all.deb
RUN rm ttf-mscorefonts-installer_3.7_all.deb


# php config
COPY ./.docker/.shared/config/php/conf.d/*  /usr/local/etc/php/conf.d/

# php-fpm pool config
COPY ${SERVICE_DIR}/php-fpm.d/* /usr/local/etc/php-fpm.d
RUN /tmp/scripts/modify_config.sh /usr/local/etc/php-fpm.d/zz-app.conf \
    "__APP_USER" \
    "${APP_USER}" \
 && /tmp/scripts/modify_config.sh /usr/local/etc/php-fpm.d/zz-app.conf \
    "__APP_GROUP" \
    "${APP_GROUP}" \
;

# workdir
ARG APP_CODE_PATH="/var/www/html"
WORKDIR "$APP_CODE_PATH"

# entrypoint
RUN mkdir -p /bin/docker-entrypoint/ \
 && cp /tmp/scripts/docker-entrypoint/* /bin/docker-entrypoint/ \
 && chmod +x -R /bin/docker-entrypoint/ \
;

RUN /tmp/scripts/cleanup.sh

CMD ["php-fpm"]
ENTRYPOINT ["/bin/docker-entrypoint/resolve-docker-host-ip.sh"]
EXPOSE 9000
