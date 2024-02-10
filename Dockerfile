# FROM  centos:latest
# RUN yum install -y --disablerepo=appstream httpd zip unzip
# ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
# WORKDIR /var/www/html/
# RUN unzip photogenic.zip
# RUN cp -rvf photogenic/* .
# RUN rm -rf photogenic photogenic.zip
# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
# EXPOSE 80 22

FROM ubuntu:22.04
 
# Install apache2, zip, and curl
RUN apt-get -y update
RUN apt-get install -y apache2
RUN apt-get install -y zip unzip wget
RUN wget https://www.free-css.com/assets/files/free-css-templates/download/page295/antique-cafe.zip
RUN unzip antique-cafe.zip
RUN mv /2126_antique_cafe/* /var/www/html
RUN rm -rf 2126_antique_cafe antique-cafe.zip
 
# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80