FROM mig/debian:bullseye as backend-stage

RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
    php \
    php-fpm \
    php-bcmath \
    php-curl \
    php-dom \
    php-gd \
    php-mbstring \
    php-mysqli \
    php-xml \
    php-soap \
    php-xsl \
    php-zip \
    php-bz2 \
    php-intl \
    php-imagick \
    nginx \
    supervisor

RUN mv /etc/php/7.4/fpm/pool.d/www.conf /etc/php/7.4/fpm/pool.d/www.conf.ori
RUN touch /etc/php/7.4/fpm/pool.d/www.conf

RUN touch /etc/php/7.4/cli/conf.d/10-phpini-overrides.ini
RUN touch /etc/php/7.4/fpm/conf.d/10-phpini-overrides.ini
RUN chmod 777 /etc/php/7.4/cli/conf.d/10-phpini-overrides.ini && chmod 777 /etc/php/7.4/fpm/conf.d/10-phpini-overrides.ini

RUN mkdir -p /var/run/php && chmod 755 /var/run/php && chown www-data:www-data /var/run/php

RUN rm -f /etc/nginx/sites-enabled/default
RUN touch /etc/nginx/sites-enabled/backend.conf

RUN touch /etc/supervisor/conf.d/backend.conf

COPY --from=composer:lts /usr/bin/composer /usr/local/bin/composer
RUN mkdir /var/www/html/backend
COPY ./ /var/www/html/backend
COPY ./.env.example /var/www/html/backend/.env
RUN chown -R 1001:1001 /var/www/html/backend
RUN chmod -R 775 /var/www/html/backend/storage/ /var/www/html/backend/bootstrap/cache
RUN chown -R 1001:www-data /var/www/html/backend/storage/ /var/www/html/backend/bootstrap/cache
WORKDIR /var/www/html/backend
USER 1001
RUN composer install
RUN rm ./entrypoint.sh
USER 0

RUN apt-get -y autoremove && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/* \
    && rm /usr/local/bin/composer

EXPOSE 9000/tcp

COPY ./entrypoint.sh /usr/bin/backend-entrypoint.sh
RUN chmod +x /usr/bin/backend-entrypoint.sh
ENTRYPOINT ["backend-entrypoint.sh"]