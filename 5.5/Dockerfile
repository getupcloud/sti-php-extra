FROM openshift/php-55-centos7:latest

USER root

RUN yum clean all -y && \
    yum install -y --setopt=tsflags=nodocs glibc-common php55-php-pecl-redis && \
    yum clean all -y

USER 1001
