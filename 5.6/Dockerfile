FROM centos/php-56-centos7:latest

USER root

RUN yum install https://www.softwarecollections.org/en/scls/remi/php56more/epel-7-x86_64/download/remi-php56more-epel-7-x86_64.noarch.rpm -y && \
    yum install -y --setopt=tsflags=nodocs reinstall glibc-common \
    more-php56-php-pecl-redis more-php56-php-mcrypt && \
    yum clean all -y

# Getup bits
RUN chmod -R a+rwx /opt/rh/httpd24/root/etc/httpd/conf.d

COPY ./s2i/bin/ $STI_SCRIPTS_PATH

USER 1001
