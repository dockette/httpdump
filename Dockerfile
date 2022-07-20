FROM dockette/debian:bullseye-slim

LABEL maintainer="sulcmil@gmail.com"

# PHP
ENV TZ=Europe/Prague

# INSTALLATION
RUN apt update && apt dist-upgrade -y && \
    # DEPENDENCIES #############################################################
    apt install -y wget curl apt-transport-https ca-certificates git unzip && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ bullseye main" > /etc/apt/sources.list.d/php.list && \
    echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" > /etc/apt/sources.list.d/caddy-fury.list && \
    apt update && \
    # CADDY ####################################################################
    apt install -y --no-install-recommends \
        caddy && \
    # PHP ######################################################################
    apt install -y --no-install-recommends \
        php7.4-apcu \
        php7.4-bz2 \
        php7.4-bcmath \
        php7.4-cli \
        php7.4-ctype \
        php7.4-curl \
        php7.4-dom \
        php7.4-fpm \
        php7.4-mbstring \
        php7.4-sqlite3 \
        php7.4-redis \
        php7.4-zip && \
    # COMPOSER #################################################################
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --2 && \
    # HTTPDUMP #################################################################
    git clone https://github.com/beyondcode/httpdump.git /srv && \
    composer -d /srv install  && \
    mkdir -p /srv/storage && \
    chmod 0755 /srv/storage && \
    chown www-data:www-data -R /srv/storage && \
    # CLEAN UP #################################################################
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get remove -y wget curl && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

COPY ./Caddyfile /etc/Caddyfile
COPY ./php.ini /etc/php/7.4/conf.d/999-php.ini
COPY ./php-fpm.conf /etc/php/7.4/php-fpm.conf
COPY ./.env /srv/.env

# WORKDIR
WORKDIR /srv

# ENTRYPOINT
COPY entrypoint.sh /usr/bin/
RUN chmod 755 /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
