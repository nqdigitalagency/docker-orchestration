#!/bin/sh
set -e

if [ ! -d "/var/www/html/vendor" ]; then
    cd /var/www/html

    composer install --optimize-autoloader --no-dev
    php artisan key:generate
    php artisan passport:keys
    php artisan migrate
    php artisan passport:client --no-interaction --personal
    php artisan config:cache
    php artisan route:cache

fi

exec "$@"
