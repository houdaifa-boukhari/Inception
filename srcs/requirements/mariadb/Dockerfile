FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install mariadb-server mariadb-client -y
	
COPY install.sh /usr/local/bin

RUN chmod +x /usr/local/bin/install.sh

ENTRYPOINT [ "/usr/local/bin/install.sh" ]