FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y 

RUN apt-get install mariadb-server mariadb-client -y && apt-get clean

RUN sed -i "s/^bind-address\s*=.*$/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

COPY install.sh /usr/local/bin

RUN chmod +x /usr/local/bin/install.sh

EXPOSE 3306

ENTRYPOINT [ "/usr/local/bin/install.sh" ]

