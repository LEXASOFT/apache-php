FROM php:8.0-apache-buster

ENV BUILD_DEPS="icu-devtools libicu-dev libjpeg62-turbo-dev libpng-dev libjpeg-dev libfreetype6-dev libldap2-dev libpq-dev libxslt-dev libxml2-dev libzip-dev zlib1g-dev" \
    LIB_DEPS="libfreetype6 libjpeg62-turbo libpq5 libpng16-16 libzip4 libxslt1.1" \
    TOOL_DEPS="git graphviz make net-tools unzip zip" \
    LIBRDKAFKA_VERSION="1.4.x" \
    PHPRDKAFKA_VERSION="5.x"

RUN a2enmod rewrite expires headers \
    && apt-get update \
    && apt-get install -y --no-install-recommends ${BUILD_DEPS} ${LIB_DEPS} ${TOOL_DEPS} \
    && cd /tmp && git clone --branch ${LIBRDKAFKA_VERSION} --depth 1 https://github.com/edenhill/librdkafka.git \
    && cd librdkafka && ./configure && make -j$(nproc) && make install \
    && cd /tmp && git clone --branch ${PHPRDKAFKA_VERSION} --depth 1 https://github.com/arnaud-lb/php-rdkafka.git \
    && cd php-rdkafka && phpize && ./configure && make all -j$(nproc) && make install \
    && pecl channel-update pecl.php.net \
    && pecl install apcu igbinary redis \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-configure zip \
    && docker-php-ext-install -j$(nproc) gd ldap pdo pdo_mysql pdo_pgsql sockets xsl zip \
    && docker-php-ext-enable apcu igbinary rdkafka redis \
    && apt-get purge --auto-remove -qy ${BUILD_DEPS} \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* /tmp/librdkafka /tmp/php-rdkafka
