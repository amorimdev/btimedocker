FROM php:7.0-fpm

MAINTAINER Jhonatan Amorim <amorim.dev@gmail.com>

# Install project dependencies
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y \
    libmemcached-dev \
    libmagickwand-dev \
    zlib1g-dev \
    vim \
    curl \
    git \
    zip \
    unzip \
    nodejs

# Install xdebug
RUN git clone -b xdebug_2_5 https://github.com/xdebug/xdebug.git php-xdebug \
    && cd php-xdebug && phpize && ./configure && make && make install && cd -

# Install memcached
RUN git clone -b php7 https://github.com/php-memcached-dev/php-memcached \
    && cd php-memcached && phpize && ./configure && make && make install && cd -

# Install redis
RUN git clone -b php7 https://github.com/phpredis/phpredis.git php-redis \
    && cd php-redis && phpize && ./configure && make && make install && cd -

# Install imagick
RUN git clone -b phpseven https://github.com/mkoppanen/imagick.git php-imagick \
    && cd php-imagick && phpize && ./configure && make && make install && cd -

# Type docker-php-ext-install to see available extensions
RUN docker-php-ext-install bcmath pdo pdo_mysql \
    && docker-php-ext-enable redis xdebug memcached imagick

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version

# Set timezone
RUN rm /etc/localtime \
    && ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
    && "date"

# Remove Temp Files
RUN rm -rf php-xdebug php-memcached php-redis php-imagick \
    && rm -rf /var/lib/apt/lists/*

# Set Symfony Alias
RUN echo 'alias sf="php app/console"' >> ~/.bashrc \
    && echo 'alias sf3="php bin/console"' >> ~/.bashrc

# Copy files
COPY config/php.ini /usr/local/etc/php/php.ini
COPY btimeapp/ /var/www/btimeapp/
COPY btimeweb/ /var/www/btimeweb/

EXPOSE 9000

WORKDIR /var/www/
