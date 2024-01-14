FROM php:7.4-apache
WORKDIR /var/www/html
RUN apt-get update && apt-get install -y \
    unzip \
    curl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /var/www/html/

RUN composer install --no-plugins --no-scripts --no-autoloader

EXPOSE 80
CMD ["apache2-foreground"]