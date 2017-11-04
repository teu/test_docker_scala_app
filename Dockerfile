FROM tutum/apache-php

RUN apt-get update && apt-get install -yq git && rm -rf /var/lib/apt/lists/*
ADD ./conf/000-default.conf /etc/apache2/sites-enabled/000-default.conf
RUN rm -fr /app
ADD ./app /app
RUN chown -R www-data /app
RUN  mkdir -p /var/www && chmod -R 777 /var/www \
    && /usr/local/bin/composer self-update

USER www-data
RUN cd /app \
    && composer install
USER root
