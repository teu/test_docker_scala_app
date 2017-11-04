FROM tutum/apache-php

# installing prerequisites
RUN apt-get update && apt-get install -yq git && rm -rf /var/lib/apt/lists/*

# add apache config
ADD ./conf/000-default.conf /etc/apache2/sites-enabled/000-default.conf
RUN rm -fr /app

# adding the application code
ADD ./app /app

# setting permissions
RUN chown -R www-data /app \
    && mkdir -p /var/www && chmod -R 777 /var/www \
    && /usr/local/bin/composer self-update

# application has to be owner by the apache user
USER www-data

# installing application code requirements
RUN cd /app \
    && composer install

# switching user back to root
USER root
