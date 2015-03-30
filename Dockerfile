FROM php:5.6-apache

RUN a2enmod rewrite

COPY config/php.ini /usr/local/etc/php/

RUN apt-get update && \
    apt-get install -y ant git zlib1g zlib1g-dev vim && \
    docker-php-ext-install mbstring zip pdo pdo_mysql && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/html/

RUN git clone https://github.com/omeka/omeka-s.git /var/www/html/
RUN ant init
COPY config/database.ini /var/www/html/config/database.ini

EXPOSE 80