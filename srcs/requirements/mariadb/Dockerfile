FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y 

RUN apt-get install mariadb-server mariadb-client -y \
    && apt-get clean

RUN sed -i "s/^bind-address\s*=.*$/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

WORKDIR /script

COPY ./script.sh /script/script.sh

RUN chmod +x script.sh

EXPOSE 3306

ENTRYPOINT [ "sh", "/script/script.sh" ]

