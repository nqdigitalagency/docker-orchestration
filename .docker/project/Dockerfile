ARG TARGET_PHP_VERSION=7.3
FROM php:${TARGET_PHP_VERSION}-fpm

ARG SERVICE_DIR="./.docker/project"
ARG SERVICE_DIR_PHP="./.docker/php-fpm"
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

# php config
COPY ./.docker/.shared/config/php/conf.d/*  /usr/local/etc/php/conf.d/

# php-fpm pool config
COPY ${SERVICE_DIR_PHP}/php-fpm.d/* /usr/local/etc/php-fpm.d
RUN /tmp/scripts/modify_config.sh /usr/local/etc/php-fpm.d/zz-app.conf \
    "__APP_USER" \
    "${APP_USER}" \
 && /tmp/scripts/modify_config.sh /usr/local/etc/php-fpm.d/zz-app.conf \
    "__APP_GROUP" \
    "${APP_GROUP}" \
;

# workdir
ARG APP_CODE_PATH_HOST=./
ARG APP_CODE_PATH="/var/www/html"
WORKDIR "$APP_CODE_PATH"

USER www-data

COPY --chown=www-data:www-data . $APP_CODE_PATH/
COPY --chown=www-data:www-data .env.example $APP_CODE_PATH/.env

RUN composer install --no-interaction --no-progress --no-dev;

# entrypoint
RUN mkdir -p /bin/docker-entrypoint/ \
 && cp /tmp/scripts/docker-entrypoint/* /bin/docker-entrypoint/ \
 && chmod +x -R /bin/docker-entrypoint/ \
;

RUN /tmp/scripts/cleanup.sh