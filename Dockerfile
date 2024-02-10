# FROM  centos:latest
# RUN yum install -y --disablerepo=appstream httpd zip unzip
# ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
# WORKDIR /var/www/html/
# RUN unzip photogenic.zip
# RUN cp -rvf photogenic/* .
# RUN rm -rf photogenic photogenic.zip
# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
# EXPOSE 80 22

FROM centos:latest

FROM centos

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Install Apache HTTP Server
RUN yum install -y httpd

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Apache HTTP Server in the foreground when the container starts
CMD ["httpd", "-D", "FOREGROUND"]
