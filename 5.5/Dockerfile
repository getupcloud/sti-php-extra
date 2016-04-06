FROM openshift/php-55-centos7:latest

USER root

RUN yum clean all -y && \
    yum install -y --setopt=tsflags=nodocs glibc-common php55-php-pecl-redis && \
    yum clean all -y

# Getup bits
RUN chmod -R a+rwx /opt/rh/httpd24/root/etc/httpd/conf.d

COPY ./s2i/bin/ $STI_SCRIPTS_PATH

USER 1001
