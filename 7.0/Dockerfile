FROM centos/php-70-centos7:latest

MAINTAINER Mateus Caruccio <mateus.caruccio@getupcloud.com>

USER root

RUN yum update -y && yum clean all -y

ENV FFMPEG_VERSION 3.4.1

RUN echo Install ffmpeg && \
    export PREFIX=/usr/local && \
    mkdir -p /tmp/ffmpeg && cd /tmp/ffmpeg && \
    curl -s http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar xzvf - && \
    cd ffmpeg-${FFMPEG_VERSION} && \
    ./configure --prefix="${PREFIX}" --extra-cflags="-I${PREFIX}/include" --extra-ldflags="-L${PREFIX}/lib" --bindir="${PREFIX}/bin" \
        --extra-libs=-ldl --enable-version3 --enable-gpl \
        --enable-postproc --enable-nonfree --enable-avresample --disable-debug --enable-small --disable-yasm && \
    make install && \
    rm -rf /tmp/ffmpeg

RUN curl -Ls https://github.com/ariya/phantomjs/releases/download/2.1.3/phantomjs > /usr/local/bin/phantomjs && \
    chmod +x /usr/local/bin/phantomjs

RUN curl -s https://rpm.nodesource.com/setup_9.x | bash - && \
    npm install gulp -g && \
    INSTALL_PKGS="rh-php70-php-devel npm nodejs gcc-c++ make ImageMagick ImageMagick-devel \
        https://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS $EXTRA_INSTALL_PKGS && \
    yum clean all -y && \
    INSTALL_PECL="igbinary memcache mongodb redis scrypt uuid xdebug pgsql imagick" && \
    pecl install --onlyreqdeps $INSTALL_PECL && \
    pecl clear-cache && \
    ( cd / && curl https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_x86_64.rpm | rpm2cpio | cpio -idvm ) && \
    rm -rf /opt/rh/httpd24/root/var/run/httpd && \
    mkdir -p /opt/rh/httpd24/root/var/run/httpd && \
    chmod -R a+rwx  /opt/rh/httpd24/root/var/run/httpd

COPY contrib/etc/ /opt/app-root/etc/
COPY contrib/scripts/ ${PHP_CONTAINER_SCRIPTS_PATH}/

USER 1001
