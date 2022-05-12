FROM php:8.1-apache

USER root

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    && docker-php-ext-install zip

RUN apt-get update && \
    apt-get install -y \
        git \
        openssh-server

RUN apt-get update && \
    apt-get install -y libxml2-dev

RUN docker-php-ext-install soap

RUN docker-php-ext-install mysqli pdo pdo_mysql \
    && docker-php-ext-enable pdo_mysql

COPY --from=composer:2.0 /usr/bin/composer /usr/local/bin/composer

RUN chown -R root:root /var/www/html

RUN a2enmod rewrite 
