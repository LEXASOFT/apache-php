FROM php:8.0.0-apache-buster

RUN a2enmod rewrite expires headers \
    && apt-get update \
    && devDependencies="icu-devtools libicu-dev libjpeg62-turbo-dev libpng-dev libjpeg-dev libfreetype6-dev libldap2-dev librdkafka-dev libxslt-dev libxml2-dev libzip-dev zlib1g-dev" \
    && apt-get install -y --no-install-recommends \
        libfreetype6 \
        libjpeg62-turbo \
        libpng16-16 \
        librdkafka++1 \
        librdkafka1 \
        libzip4 \
        libxslt1.1 \
        zip \
        net-tools \
        graphviz \
        $devDependencies \
    && pecl install apcu igbinary rdkafka redis \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-configure zip \
    && docker-php-ext-install -j$(nproc) gd ldap pdo pdo_mysql sockets xsl zip \
    && docker-php-ext-enable apcu igbinary rdkafka redis \
    && apt-get purge --auto-remove -qy $devDependencies \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
