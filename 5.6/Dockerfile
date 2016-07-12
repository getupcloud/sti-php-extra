FROM centos/php-56-centos7:latest

USER root

RUN yum install https://www.softwarecollections.org/en/scls/remi/php56more/epel-7-x86_64/download/remi-php56more-epel-7-x86_64.noarch.rpm -y && rpm -Uvh http://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm && \
    yum install -y --setopt=tsflags=nodocs reinstall glibc-common \
    more-php56-php-pecl-redis more-php56-php-mcrypt newrelic-php5 && NR_INSTALL_SILENT=1 newrelic-install install && \
    yum clean all -y

COPY ./s2i/bin/ $STI_SCRIPTS_PATH
COPY ./contrib/newrelic.ini.template /opt/app-root/etc/

RUN rm -rf /opt/rh/httpd24/root/var/run/httpd && mkdir -p /opt/rh/httpd24/root/var/run/httpd

# Getup bits
RUN chmod -R a+rwx /opt/rh/httpd24/root/etc/httpd/conf.d

RUN chown -R 1001:0 /opt/app-root /tmp/sessions && \
    chmod -R a+rwx /tmp/sessions && \
    chmod -R ug+rwx /opt/app-root && \
#    chmod -R a+rwx /opt/rh/php56/root/etc && \
    chmod -R a+rwx /opt/rh/httpd24/root/etc/httpd/conf.d && \
    chmod -R a+rwx /opt/rh/httpd24/root/var/run/httpd

COPY ./s2i/bin/ $STI_SCRIPTS_PATH

USER 1001
