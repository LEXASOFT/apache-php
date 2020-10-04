FROM php:7.2-apache-stretch

RUN a2enmod rewrite expires headers \
    && apt-get update \
    && devDependencies="icu-devtools libicu-dev libjpeg62-turbo-dev libpng-dev libjpeg-dev libfreetype6-dev libldap2-dev librdkafka-dev libxslt-dev libxml2-dev libzip-dev zlib1g-dev" \
    && apt-get install -y --no-install-recommends \
        libfreetype6 \
        libjpeg62-turbo \
        libpng16-16 \
        libzip4 \
        libxslt1.1 \
        zip \
        net-tools \
        graphviz \
        $devDependencies \
    && mkdir -p /tmp/librdkafka \
    && curl -fsSL https://github.com/edenhill/librdkafka/archive/v1.4.4.tar.gz | tar xvz -C /tmp/librdkafka --strip 1 \
    && cd /tmp/librdkafka \
    && ./configure \
    && make -j$(nproc) \
    && make -j$(nproc) install \
    && rm -r /tmp/librdkafka \
    && pecl install apcu igbinary rdkafka redis \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install -j$(nproc) gd ldap pdo pdo_mysql sockets xsl zip \
    && docker-php-ext-enable apcu igbinary rdkafka redis \
    && apt-get purge --auto-remove -qy $devDependencies \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
