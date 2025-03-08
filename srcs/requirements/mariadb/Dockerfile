FROM debian:bookworm

EXPOSE 3306

RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server mariadb-client && apt-get clean

COPY install.sh /usr/local/bin

RUN chmod +x /usr/local/bin/install.sh

ENTRYPOINT [ "/usr/local/bin/install.sh" ]