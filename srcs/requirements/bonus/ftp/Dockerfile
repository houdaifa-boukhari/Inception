FROM debian:bookworm

RUN apt-get update && apt-get install -y vsftpd

# Create the required directory for vsftpd
RUN mkdir -p /var/run/vsftpd/empty

COPY vsftpd.conf /etc/vsftpd.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Create FTP user (example: ftpuser / ftppass)
RUN useradd -m ftpuser && echo "ftpuser:ftppass" | chpasswd

# Expose FTP ports
EXPOSE 21 30000-30009

CMD ["/start.sh"]