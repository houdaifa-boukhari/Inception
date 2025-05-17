FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y fail2ban iptables && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./conf/jail.local /etc/fail2ban/jail.local
COPY ./conf/filter.d/wordpress.conf /etc/fail2ban/filter.d/wordpress.conf
COPY ./conf/filter.d/vsftpd.conf /etc/fail2ban/filter.d/vsftpd.conf
COPY ./conf/filter.d/iptables-docker.conf /etc/fail2ban/action.d/iptables-docker.conf

# EXPOSE 22

CMD ["fail2ban-server", "-f", "-x", "start"]