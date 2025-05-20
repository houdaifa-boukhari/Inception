FROM debian:bookworm

RUN apt-get update && apt-get install -y vsftpd

RUN mkdir -p /var/run/vsftpd/empty

COPY vsftpd.conf /etc/vsftpd.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 21 30000-30009

CMD ["/start.sh"]