# Upstream's Dockerfile (app/Dockerfile) with three changes: the source is copied from app/vapi/,
# the composer image is pinned to a tag instead of latest, and the environment upstream's
# docker-compose.yml sets for the www service is baked in as ENV (the image deletes .env).
FROM php:7.4.27-apache 
RUN docker-php-ext-install mysqli pdo_mysql
RUN apt-get update \
    && apt-get install -y libzip-dev \
    && apt-get install -y zlib1g-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install zip
COPY --from=composer:2.8 /usr/bin/composer /usr/local/bin/composer

COPY app/vapi /var/www/html/vapi

RUN rm /var/www/html/vapi/.env

RUN echo "flag{ssrf_e0pgt3az9zeqdd4fhatc}" > /flag.txt

ENV APP_NAME=Laravel \
    APP_ENV=local \
    APP_KEY="base64:JUXTsCKQubRlvxGv6sVwkFL2rJ/gSksD4B/68948Mww:" \
    APP_DEBUG=true \
    APP_URL=http://vapi.test \
    SERVER_PORT=80 \
    LOG_CHANNEL=errorlog \
    LOG_LEVEL=debug \
    DB_CONNECTION=mysql \
    DB_HOST=db \
    DB_PORT=3306 \
    DB_DATABASE=vapi \
    DB_USERNAME=root \
    DB_PASSWORD=vapi123456 \
    BROADCAST_DRIVER=log \
    CACHE_DRIVER=file \
    FILESYSTEM_DRIVER=local \
    QUEUE_CONNECTION=sync \
    SESSION_DRIVER=file \
    SESSION_LIFETIME=120 \
    MEMCACHED_HOST=127.0.0.1 \
    REDIS_HOST=127.0.0.1 \
    REDIS_PASSWORD="" \
    REDIS_PORT=6379 \
    MAIL_MAILER=smtp \
    MAIL_HOST=mailhog \
    MAIL_PORT=1025 \
    MAIL_USERNAME="" \
    MAIL_PASSWORD="" \
    MAIL_ENCRYPTION="" \
    MAIL_FROM_ADDRESS="" \
    MAIL_FROM_NAME=Laravel \
    AWS_DEFAULT_REGION=us-east-1 \
    AWS_USE_PATH_STYLE_ENDPOINT=false \
    PUSHER_APP_CLUSTER=mt1 \
    MIX_PUSHER_APP_CLUSTER=mt1

CMD ["php","/var/www/html/vapi/artisan","serve","--host=0.0.0.0"]

# CyberCTF per-player flags: the flags above and in app/CustomClasses/Variables.php are only the
# development fallback. ctf-entrypoint.sh puts the player's flags in their place at every start
# (CTF_FLAG_MAIN, the ServerSurfer flag, in /flag.txt; CTF_FLAG_API6, _API7, _API10,
# _JUST_WEAK_TOKEN and _STICKY_NOTES in Variables.php), then runs the original command,
# repeated here unchanged.
RUN mkdir -p /usr/local/share/ctf \
 && cp /var/www/html/vapi/app/CustomClasses/Variables.php /usr/local/share/ctf/Variables.php
COPY ctf-entrypoint.sh /usr/local/bin/ctf-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/ctf-entrypoint.sh"]
CMD ["php","/var/www/html/vapi/artisan","serve","--host=0.0.0.0"]
