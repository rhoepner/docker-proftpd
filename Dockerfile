# Install packages
# -----------------------------------------------------------------------------
# build this image using 
#
#   docker build -t your-name/proftpd .
#
# or pull using
#
#   docker pull rhoepner/proftpd
# 
FROM ubuntu

# Install packages
# -----------------------------------------------------------------------------
# - install openssl needed for FTPS
# - install proftpd
# (-y) to suppress interactive questions 
RUN apt-get update -y
RUN apt-get install -y openssl proftpd

# Copy adjusted configuration files
# -----------------------------------------------------------------------------
COPY ./files/proftpd/* /etc/proftpd/

# Certificates for TLS
# -----------------------------------------------------------------------------
# - create certificate
# - adjust file permissions
RUN openssl req -x509 -newkey rsa:1024 -keyout /etc/ssl/private/proftpd.key -out /etc/ssl/certs/proftpd.crt -nodes -days 365 -subj "/C=DE/ST=Denial/L=Cologne/O=Dis/CN=localhost" && \
    chmod 0600 /etc/ssl/private/proftpd.key && \ 
	chmod 0640 /etc/ssl/private/proftpd.key

# FTP user
# -----------------------------------------------------------------------------
# - username: ftpuser
# - password: password
RUN useradd --create-home --shell /bin/bash --password $(openssl passwd -1 password) ftpuser

# FTP root
# ----------------------------------------------------------------------------- 
# - create ftp root directory 
# - change owner to ftpuser to allow full access 
RUN mkdir /ftp && \
    chown ftpuser /ftp 

# Need to expose FTP port
# -----------------------------------------------------------------------------
EXPOSE 21

# Need to expose a limited range of passive ports
# -----------------------------------------------------------------------------
EXPOSE 57300-57350

# Start proftpd
# -----------------------------------------------------------------------------
CMD ["proftpd", "--nodaemon", "-c", "/etc/proftpd/proftpd.conf"]