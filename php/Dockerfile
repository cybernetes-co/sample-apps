FROM php:8.2-fpm-alpine

RUN apk add --no-cache nginx && mkdir /var/www/app

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.php /var/www/app/index.php

WORKDIR /var/www/app

RUN chmod -R 755 /var/www/app && chown -R www-data:www-data /var/www/app

EXPOSE 80

# Start Nginx and PHP-FPM
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]

