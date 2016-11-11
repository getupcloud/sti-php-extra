FROM centos/php-56-centos7:latest

USER root

RUN yum install https://www.softwarecollections.org/en/scls/remi/php56more/epel-7-x86_64/download/remi-php56more-epel-7-x86_64.noarch.rpm -y && rpm -Uvh http://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm && \
    yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum install -y --setopt=tsflags=nodocs glibc-common more-php56-php-pecl-redis more-php56-php-mcrypt newrelic-php5 && NR_INSTALL_SILENT=1 newrelic-install install && \
    yum install -y ImageMagick && \
    yum clean all -y

#====================================================================
# ffmpeg
ENV FFMPEG_VERSION 3.0
ENV SRC /usr/local
RUN DIR=$(mktemp -d) && cd /tmp && \
              curl -Os http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz && \
              tar xzvf ffmpeg-${FFMPEG_VERSION}.tar.gz && \
              cd ffmpeg-${FFMPEG_VERSION} && \
              ./configure --prefix="${SRC}" --extra-cflags="-I${SRC}/include" --extra-ldflags="-L${SRC}/lib" --bindir="${SRC}/bin" \
              --extra-libs=-ldl --enable-version3 --enable-gpl \
              --enable-postproc --enable-nonfree --enable-avresample --disable-debug --enable-small --disable-yasm && \
              make && \
              make install && \
              make distclean && \
              hash -r && \
              rm -rf ${DIR}
#====================================================================


COPY ./s2i/bin/ $STI_SCRIPTS_PATH
COPY ./contrib/newrelic.ini.template /opt/app-root/etc/

RUN rm -rf /opt/rh/httpd24/root/var/run/httpd && mkdir -p /opt/rh/httpd24/root/var/run/httpd

# Getup bits
RUN chmod -R a+rwx /opt/rh/httpd24/root/etc/httpd/conf.d

RUN chown -R 1001:0 /opt/app-root /tmp/sessions && \
    chmod -R a+rwx /tmp/sessions && \
    chmod -R ug+rwx /opt/app-root && \
    chmod -R a+rwx /etc/opt/rh/rh-php56/php.d && \
    chmod -R a+rwx /opt/rh/httpd24/root/etc/httpd/conf.d && \
    chmod -R a+rwx /opt/rh/httpd24/root/var/run/httpd

COPY ./s2i/bin/ $STI_SCRIPTS_PATH

USER 1001
