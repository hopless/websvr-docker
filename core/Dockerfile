FROM ubuntu:latest

RUN apt-get update && apt-get install -y software-properties-common curl libapache2-mod-wsgi
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
# Install apache, PHP, and supplimentary programs. openssh-server, curl, and lynx-cur are for debugging the container.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    apache2 php7.1 php7.1-mysql php7.1-common php7.1-cli libapache2-mod-php7.1 curl 

# Enable apache mods.
RUN a2enmod php7.1
RUN a2enmod rewrite

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf && \
    rm -rf /var/lib/apt/lists/*

ADD conf/000-default.conf /etc/apache2/sites-available/000-default.conf
ADD conf/php.ini /etc/php/7.1/apache2/php.ini

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Expose apache.
EXPOSE 80 3306

# Copy this repo into place.
ADD www /var/www/site

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /usr/sbin/apache2ctl -D FOREGROUND

