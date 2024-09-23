FROM php:8.2-apache

# Install necessary packages
RUN apt-get update && apt-get install -y libzip-dev zip unzip git && docker-php-ext-install zip

# Enable Apache modules
RUN a2enmod rewrite
RUN a2enmod ssl

# Set Apache environment variables
ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_LOG_DIR=/var/log/apache2
ENV APACHE_PID_FILE=/var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR=/var/run/apache2
ENV APACHE_LOCK_DIR=/var/lock/apache2

# Create necessary directories
RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

# Ensure Apache can access these directories
RUN chown -R www-data:www-data $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR
RUN chmod 755 $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

# Clean up
RUN rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /var/www/html

