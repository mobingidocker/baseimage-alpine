FROM mobingi/baseimage:ubuntu-16.04
LABEL com.mobingi.code_dir="/var/www/html/public"

RUN sed -e "s@http://archive.ubuntu.com/@http://linux.yz.yamagata-u.ac.jp/pub/linux/ubuntu-archive/@g" /etc/apt/sources.list -i
RUN apt-get update && apt-get install -y --no-install-recommends \
		apache2 \
		software-properties-common \
    cron \
	&& apt-get clean \
	&& rm -fr /var/lib/apt/lists/*

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -y --no-install-recommends \
		libapache2-mod-php7.1 \
		php7.1 \
		php7.1-cli \
		php7.1-curl \
		php7.1-dev \
		php7.1-gd \
		php7.1-imap \
		php7.1-mbstring \
		php7.1-mcrypt \
		php7.1-mysql \
		php7.1-pgsql \
		php7.1-pspell \
		php7.1-xml \
		php7.1-xmlrpc \
		php-apcu \
		php-memcached \
		php-pear \
		php-redis \
	&& apt-get clean \
	&& rm -fr /var/lib/apt/lists/*

ADD scripts /scripts
RUN /scripts/install-composer.sh
RUN a2enmod rewrite
COPY files/000-default.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80
