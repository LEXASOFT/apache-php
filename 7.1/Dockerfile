FROM php:7.1-apache-stretch

ENV BUILD_DEPS="icu-devtools libicu-dev libjpeg62-turbo-dev libpng-dev libjpeg-dev libfreetype6-dev libldap2-dev libxslt-dev libxml2-dev libzip-dev zlib1g-dev" \
    LIB_DEPS="libfreetype6 libjpeg62-turbo libpng16-16 libzip4 libxslt1.1" \
    TOOL_DEPS="git graphviz make net-tools unzip zip" \
    LIBRDKAFKA_VERSION="1.4.x"

RUN a2enmod rewrite expires headers \
    && apt-get update \
    && apt-get install -y --no-install-recommends ${BUILD_DEPS} ${LIB_DEPS} ${TOOL_DEPS} \
    && cd /tmp && git clone --branch ${LIBRDKAFKA_VERSION} --depth 1 https://github.com/edenhill/librdkafka.git \
    && cd librdkafka && ./configure && make -j$(nproc) && make install \
    && pecl channel-update pecl.php.net \
    && pecl install apcu igbinary rdkafka redis \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install -j$(nproc) gd ldap pdo pdo_mysql sockets xsl zip \
    && docker-php-ext-enable apcu igbinary rdkafka redis \
    && apt-get purge --auto-remove -qy ${BUILD_DEPS} \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* /tmp/librdkafka
