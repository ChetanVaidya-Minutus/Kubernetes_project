# FROM  centos:latest
# RUN yum install -y --disablerepo=appstream httpd zip unzip
# ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
# WORKDIR /var/www/html/
# RUN unzip photogenic.zip
# RUN cp -rvf photogenic/* .
# RUN rm -rf photogenic photogenic.zip
# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
# EXPOSE 80 22

# Use a specific version of CentOS instead of the latest one
FROM centos:8

# Create a group and user for Apache HTTP Server
RUN groupadd apache && \
    useradd -g apache -r -s /sbin/nologin apache

# Ensure EPEL repository is available
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

# Update package lists and install required dependencies
RUN microdnf update -y && \
    microdnf install -y epel-release httpd php php-mysql zip unzip tar -q --setopt=tsflags=nodocs && \
    microdnf clean all -y

# Download PHP template as a backup option
ADD https://www.phpmyadmin.net/packages/files/5.2/phpMyAdmin-5.2.0-all-languages.tar.gz /tmp/
RUN mkdir -p /var/www/html/ && \
    tar zxf /tmp/phpMyAdmin-5.2.0-all-languages.tar.gz -C /var/www/html/ --strip-components 1 && \
    rm /tmp/phpMyAdmin-5.2.0-all-languages.tar.gz

# Remove unnecessary files to reduce final image size
RUN find /var/www/html/ -type f \( ! -name '*.php*' \) -delete && \
    find /var/www/html/ -depth 1 -mindepth 1 -exec rm -rf {} \;

# Add the HTML templates
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip photogenic.zip
RUN cp -rvf photogenic/* .
RUN rm -rf photogenic photogenic.zip

# Configure ownership of web root directory
RUN chown -R apache:apache /var/www/html/

# Set permissions for executables
RUN chmod 755 /var/www/html/

# Expose ports
EXPOSE 80 22

# Run Apache HTTP Server as the foreground process
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]