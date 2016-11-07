FROM openshift/php-55-centos7:latest

USER root

RUN yum clean all -y && \
    yum install https://www.softwarecollections.org/repos/remi/php55more/epel-7-x86_64/noarch/remi-php55more-epel-7-x86_64-1-2.noarch.rpm -y && rpm -Uvh http://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm && \
    yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum install -y --setopt=tsflags=nodocs glibc-common php55-php-pecl-redis php55-php-mcrypt newrelic-php5 && NR_INSTALL_SILENT=1 newrelic-install install && \
    yum clean all -y

COPY ./s2i/bin/ $STI_SCRIPTS_PATH
COPY ./contrib/newrelic.ini.template /opt/app-root/etc/

RUN rm -rf /opt/rh/httpd24/root/var/run/httpd && mkdir -p /opt/rh/httpd24/root/var/run/httpd

RUN chown -R 1001:0 /opt/app-root /tmp/sessions && \
    chmod -R a+rwx /tmp/sessions && \
    chmod -R ug+rwx /opt/app-root && \
    chmod -R a+rwx /opt/rh/php55/root/etc && \
    chmod -R a+rwx /opt/rh/httpd24/root/etc/httpd/conf.d && \
    chmod -R a+rwx /opt/rh/httpd24/root/var/run/httpd

COPY ./s2i/bin/ $STI_SCRIPTS_PATH

USER 1001
