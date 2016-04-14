FROM centos/php-56-centos7:latest

USER root

RUN yum install https://www.softwarecollections.org/en/scls/remi/php56more/epel-7-x86_64/download/remi-php56more-epel-7-x86_64.noarch.rpm -y && \
    yum install -y --setopt=tsflags=nodocs reinstall glibc-common \
    more-php56-php-pecl-redis more-php56-php-mcrypt && \
    yum clean all -y

USER 1001
