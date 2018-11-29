FROM php:apache
MAINTAINER Alexey Gudym <lexasoft83@gmail.com>

RUN a2enmod rewrite expires headers \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libmcrypt-dev \
        libldap2-dev \
        libxslt-dev \
        libzip-dev \
        zip \
        net-tools \
    && pecl install apcu mcrypt-1.0.1 \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install gd ldap pdo pdo_mysql xsl zip \
    && docker-php-ext-enable apcu mcrypt \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
