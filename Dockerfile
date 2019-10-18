#  Dockerfile for base Alpine with
#  Apache and PHP
#
#  Use alpine:latest rather than a named version for now.
#  Should probably make our own known-good version (Zach
#  probably has this planned already)
#
FROM alpine:latest

#  Install Apache2 and php
#  On one line so have only a single layer within the image (per Zach)
#
RUN apk add --no-cache \
    apache2-proxy apache2-ssl apache2-utils curl git logrotate openssl \
    php7 php7-fpm php7-opcache

#  Apache2 config info
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

WORKDIR /var/www/localhost/htdocs

#  Connect the container to port 80; will later change to 443?
EXPOSE 80

#  Start Apache automatically when container starts
#
#  tried to install rc-service but some problems so this works. . .
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

