FROM debian:bookworm

EXPOSE 3306

RUN apt update && apt upgrade -y && apt install mariadb-server mariadb-client -y && sudo apt clean

COPY install.sh /usr/local/bin

RUN chmod +x /usr/local/bin/install.sh

ENTRYPOINT [ "/usr/local/bin/install.sh" ]