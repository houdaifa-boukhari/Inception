FROM debian:bookworm

# Install required packages
RUN apt-get update && apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Generate a self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/nginx.key \
    -out /etc/nginx/nginx.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Department/CN=hel-bouk.42.fr"

# Copy NGINX configuration
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Expose HTTPS port
EXPOSE 443

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
