FROM debian:jessie

MAINTAINER Andrea Sosso <andrea@sosso.me>

# Install dependencies
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
        ca-certificates \
        curl \
        git \
        php5 php5-apcu php5-cli php5-curl php5-imagick php5-fpm php5-gd php5-intl php5-mysql php5-sqlite \
        sudo \
		unzip \
        vim \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define php-fpm configuration
RUN echo 'clear_env = no' >> /etc/php5/fpm/pool.d/www.conf \
    && sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini \
    && sed -e 's/;listen\.owner/listen.owner/' -i /etc/php5/fpm/pool.d/www.conf \
    && sed -e 's/;listen\.group/listen.group/' -i /etc/php5/fpm/pool.d/www.conf \
    && sed -e 's/listen = /listen = 9000 ;/' -i /etc/php5/fpm/pool.d/www.conf \
    && echo "opcache.enable=1" >> /etc/php5/mods-available/opcache.ini \
    && sed -e 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf

# Add vhost for nginx container
ADD docker/default.vhost.conf /etc/nginx/conf.d/default.conf

# Start script
ADD docker/start.sh /start

# Copy vBulletin files and UnzipIt
ADD vbulletin5.zip vb.zip
RUN unzip vb.zip \
    && mkdir -p /var/www \
    && mv upload/* /var/www
RUN chown -R www-data:www-data /var/www \
    && chmod +x /start

VOLUME ["/var/www", "/etc/nginx/conf.d"]
ENV HOME /root
WORKDIR /var/www

EXPOSE 9000

CMD ["/start"]
