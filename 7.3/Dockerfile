FROM php:7.3-apache-stretch

RUN a2enmod rewrite expires headers \
    && apt-get update \
    && devDependencies="icu-devtools libicu-dev libjpeg62-turbo-dev libpng-dev libjpeg-dev libfreetype6-dev libmcrypt-dev libldap2-dev libxslt-dev libxml2-dev libzip-dev zlib1g-dev" \
    && apt-get install -y --no-install-recommends \
        libfreetype6 \
        libjpeg62-turbo \
        libmcrypt4 \
        libpng16-16 \
        libzip4 \
        libxslt1.1 \
        zip \
        net-tools \
        $devDependencies \
    && pecl install apcu \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install -j$(nproc) gd ldap pdo pdo_mysql xsl zip \
    && curl -fsSL "https://pecl.php.net/get/mcrypt" -o mcrypt.tgz \
    && mkdir -p /tmp/mcrypt \
    && tar -xf mcrypt.tgz -C /tmp/mcrypt --strip-components=1 \
    && rm mcrypt.tgz \
    && docker-php-ext-install -j$(nproc) /tmp/mcrypt \
    && rm -r /tmp/mcrypt \
    && docker-php-ext-enable apcu mcrypt \
    && apt-get purge --auto-remove -qy $devDependencies \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
