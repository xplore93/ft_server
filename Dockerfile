FROM debian:buster-slim
LABEL maintainer = "Eugeniu Stina <estina@student.42madrid.com>"

# Set alias to silence he output and ARG to silence a warning
ARG DEBIAN_FRONTEND=noninteractive

# Install Nginx, MySQL, PHP, Wget and LibNSS3-Tools
RUN apt-get update && \
	apt-get install -y nginx mariadb-server php-fpm php-mysql wget libnss3-tools

# Copy the config file for Nginx
COPY srcs/wordpress /etc/nginx/sites-available/wordpress
RUN ln -fs /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/default

# Download and unpack Wordpress
RUN wget https://wordpress.org/latest.tar.gz && \
	cp latest.tar.gz /var/www/html/ && rm latest.tar.gz && \
	cd /var/www/html/ && ls && tar -xf latest.tar.gz && rm latest.tar.gz && \
	cd wordpress && cp -r * ../ && cd .. && rm -rf wordpress index.nginx-debian.html
COPY srcs/wp-config.php /var/www/html/

#SLL SETUP
RUN mkdir ~/mkcert &&\
	cd ~/mkcert &&\
	wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.1/mkcert-v1.4.1-linux-amd64 > /dev/null &&\
	mv mkcert-v1.4.1-linux-amd64 mkcert &&\
  	chmod +x mkcert &&\
	./mkcert -install && ./mkcert localhost

#DATABASE SETUP
COPY srcs/wordpress.sql .
RUN service mysql start && \
	echo "CREATE DATABASE wordpress; \
	GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';\
	FLUSH PRIVILEGES;update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -u root && \
	mysql wordpress -u root --password=  < wordpress.sql && rm wordpress.sql

#PHPMYADMIN INSTALL
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.0-rc1/phpMyAdmin-5.0.0-rc1-all-languages.tar.gz > /dev/null && \
	mkdir /var/www/html/phpmyadmin && \
	tar xzf phpMyAdmin-5.0.0-rc1-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin && \
	rm phpMyAdmin-5.0.0-rc1-all-languages.tar.gz
COPY srcs/config.inc.php /var/www/html/phpmyadmin/

#ALLOW NGINX USER
RUN chown -R www-data:www-data /var/www/* && \
	chmod -R 755 /var/www/*

# Open port 80 and 443
EXPOSE 80 443

# Execute when container starts
CMD service nginx start && \
	service mysql start && \
	service php7.3-fpm start && \
	sleep infinity
