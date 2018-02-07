FROM centos/php-70-centos7:latest

MAINTAINER Mateus Caruccio <mateus.caruccio@getupcloud.com>

USER root

RUN yum update -y && \
    curl -s https://rpm.nodesource.com/setup_9.x | bash - && \
    INSTALL_PKGS="npm nodejs gcc-c++ make \
        http://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm \
        https://li.nux.ro/download/nux/dextop/el7/x86_64//phantomjs-2.1.1-1.el7.nux.x86_64.rpm" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    yum clean all -y && \
    pecl install imagick && \
    pecl clear-cache && \
    ( cd /opt/rh/httpd24/root && \
    curl https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_x86_64.rpm | rpm2cpio | cpio -idvm ) && \
    rm -rf /opt/rh/httpd24/root/var/run/httpd && \
    mkdir -p /opt/rh/httpd24/root/var/run/httpd && \
    chmod -R a+rwx  /opt/rh/httpd24/root/var/run/httpd

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

USER 1001
