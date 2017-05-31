FROM php:7.0-apache
LABEL maintainer Daniel Palumbo <daniel.palumbo@heig-vd.ch>
LABEL maintainer Christopher Meier <christopher.meier@heig-vd.ch>


# We copy our custom configuration.
COPY ./conf /etc/apache2/

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

RUN a2enmod proxy proxy_http && a2ensite 000* 001*