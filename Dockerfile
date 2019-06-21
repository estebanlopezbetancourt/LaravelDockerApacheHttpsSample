FROM php:7.2-apache
RUN apt-get update \
	&& apt-get install -y unzip libssl1.0-dev wget libxrender-dev libxext-dev openssl \
		libfontconfig-dev \
	&& docker-php-ext-install pdo pdo_mysql

#TODO: trying to setting up all required php extensions for laravel
# RUN apt-get --yes --force-yes install software-properties-common
# RUN add-apt-repository ppa:ondrej/php && apt-get update && apt-get --yes --force-yes install	 \
# php7 \
# php7-fpm \
# php7-pdo \
# php7-pdo_mysql \
# php7-mcrypt \
# php7-mbstring \
# php7-xml \
# php7-openssl \
# php7-json \
# php7-phar \
# php7-zip \
# php7-dom \
# php7-session \
# php7-tokenizer \
# php7-ctype \
# php7-zlib

#ADD . /code
#RUN chown -R www-data:www-data /code

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
	&& php composer-setup.php \
	&& php -r "unlink('composer-setup.php');" \
	&& mv composer.phar /usr/bin/composer
RUN rm -f /tmp/wkhtmltox.tar.xz \
	&& wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz -O /tmp/wkhtmltox.tar.xz \
	&& tar xvf /tmp/wkhtmltox.tar.xz -C /tmp \
	&& cp /tmp/wkhtmltox/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf

RUN apt-get --yes --force-yes install iputils-ping 
RUN apt-get update && apt-get --yes --force-yes install netcat


RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2ensite default-ssl
RUN apt-get install ssl-cert
ENTRYPOINT ["/bin/bash"]

#then into container
#RUN yes | cp -rf /config/default.conf /etc/apache2/conf-enabled/default.conf
#RUN source /etc/apache2/envvars
#RUN apache2 -DFOREGROUND