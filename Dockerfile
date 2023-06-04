FROM php:8.1 as php

RUN apt-get update -y
RUN apt-get install -y unzip libpq-dev libcurl4-gnutls-dev
RUN docker-php-ext-install pdo pdo_pgsql pcntl bcmath


RUN pecl install -o -f redis \
    && rm -rf  /tmp/pear \
    && docker-php-ext-enable redis

WORKDIR /var/www
COPY . .

# Install composer dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer




ENV PORT=8000

RUN chmod +x docker/entrypoint.sh

ENTRYPOINT [ "docker/entrypoint.sh" ]