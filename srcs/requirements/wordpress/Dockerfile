FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y php-fpm  php-mysqli curl wget

RUN  sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf

WORKDIR /works

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/install.sh /usr/local/bin/install.sh

EXPOSE 9000

ENTRYPOINT [ "bash", "/usr/local/bin/install.sh" ]