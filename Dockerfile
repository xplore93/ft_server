FROM	debian:buster-slim
LABEL	maintainer = "estina"

# Set alias to silence he output and ARG to silence a warning
RUN	alias hide=/dev/null
ARG DEBIAN_FRONTEND=noninteractive

# Updating the system in silence and install apt-utils
RUN	apt-get update > hide
RUN apt-get install -y --no-install-recommends apt-utils > hide

# Install nginx
RUN apt-get install -y nginx > hide

# Install wget
RUN apt-get install -y wget > hide

# Install MariaDB
RUN apt-get install -y mariadb-server > hide
RUN service mysql start

# Install PHP
RUN apt-get install -y php-fpm php-mysql > hide

# Download and unpack Wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN cp latest.tar.gz /var/www/html/ && rm latest.tar.gz
RUN cd /var/www/html/ && ls && tar -xf latest.tar.gz && rm latest.tar.gz &&\
	cd wordpress && cp -r * ../ && cd .. && rm -rf wordpress index.nginx-debian.html

# Copy the config file for NGINX
COPY srcs/nginx-host-conf ./root/
RUN cp /root/nginx-host-conf /etc/nginx/sites-available/
RUN cd /etc/nginx/sites-available/ && rm default
RUN cd /etc/nginx/sites-enabled/ && rm default
RUN ln -s /etc/nginx/sites-available/ /etc/nginx/sites-enabled/

#SLL SETUP
RUN mkdir ~/mkcert &&\
	cd ~/mkcert &&\
	wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64 &&\
	mv mkcert-v1.1.2-linux-amd64 mkcert &&\
  	chmod +x mkcert &&\
	./mkcert -install && ./mkcert localhost

RUN service nginx restart

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]