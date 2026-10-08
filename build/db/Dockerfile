# The db service of upstream's docker-compose.yml: mysql:8.0 with its environment, its command
# (native password authentication) and its init script. initdb/vapi.sql is an unchanged copy of
# build/www/app/database/vapi.sql, because a build folder is its own Docker context (upstream
# mounts that folder at /docker-entrypoint-initdb.d; its conf/ folder holds only .gitkeep).
FROM mysql:8.0
ENV MYSQL_DATABASE=vapi \
    MYSQL_USER=vapi \
    MYSQL_PASSWORD=vapi123456 \
    MYSQL_ROOT_PASSWORD=vapi123456
COPY initdb/ /docker-entrypoint-initdb.d/
CMD ["mysqld", "--default-authentication-plugin=mysql_native_password"]
