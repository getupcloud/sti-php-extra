FROM centos/php-56-centos7:latest

USER root

RUN yum install -y --setopt=tsflags=nodocs reinstall glibc-common \
    more-php56-php-pecl-redis && \
    yum clean all -y

USER 1001
