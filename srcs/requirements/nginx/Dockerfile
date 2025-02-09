FROM debian:11.9

RUN apt-get update && apt-get install -y nginx openssl && apt-get clean

RUN rm /etc/nginx/sites-enabled/default

COPY ./html /var/www/html

COPY ./ssl /etc/nginx/ssl

