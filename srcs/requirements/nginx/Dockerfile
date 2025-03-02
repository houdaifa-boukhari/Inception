FROM debian:bookworm

# Install required packages
RUN apt-get update && apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Copy NGINX configuration and SSL certificates
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/nginx.crt /etc/nginx/nginx.crt
COPY ./conf/nginx.key /etc/nginx/nginx.key

# Expose HTTPS port
EXPOSE 443

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
