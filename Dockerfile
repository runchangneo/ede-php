ARG PHP_IMAGE
FROM $PHP_IMAGE

ARG TZ
ARG CONTAINER_PACKAGE_URL
ARG IPE_PATH
ARG PHP_EXTENSIONS
ARG COMPOSER_PATH
ARG COMPOSER_REPOSITORY_URL

RUN if [ $CONTAINER_PACKAGE_URL ] ; then sed -i "s/dl-cdn.alpinelinux.org/$CONTAINER_PACKAGE_URL/g" /etc/apk/repositories ; fi

RUN apk --no-cache add tzdata \
    && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
    && echo "$TZ" > /etc/timezone

# Fix: https://github.com/docker-library/php/issues/240
RUN apk add gnu-libiconv libstdc++ --no-cache --repository http://$CONTAINER_PACKAGE_URL/alpine/edge/community/ --allow-untrusted
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

# Install php extensions
ADD $IPE_PATH /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && install-php-extensions $(echo "$PHP_EXTENSIONS" | sed 's/,/ /g')

# Install composer
ADD $COMPOSER_PATH /usr/local/bin/composer
# RUN chmod +x /usr/local/bin/composer && /usr/local/bin/composer config -g repo.packagist composer $COMPOSER_REPOSITORY_URL

# php image's www-data user uid & gid are 82, change them to 1000 (primary user)
RUN apk --no-cache add shadow && usermod -u 1000 www-data && groupmod -g 1000 www-data

WORKDIR /www
