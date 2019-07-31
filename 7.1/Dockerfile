FROM centos/php-71-centos7:latest

MAINTAINER Mateus Caruccio <mateus.caruccio@getupcloud.com>

SHELL ["/bin/bash", "-c"]

USER root

ENV EXTRA_REPOS="epel-release http://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm" \
    INSTALL_PKGS="glibc-common rh-php71-* sclo-php71-* rh-nodejs10-* newrelic-php5" \
    ENABLE_REPOS="centos-sclo-sclo-testing centos-sclo-rh-testing epel-release" \
    REMOVE_PKGS="" \
    FFMPEG_VERSION="3.4.1" \
    FFMPEG_PREFIX="/usr/local" \
    PHANTOMJS_URL="https://copr-be.cloud.fedoraproject.org/results/harbottle/main/epel-7-x86_64/00850954-phantomjs/phantomjs-2.1.1-3.el7.harbottle.x86_64.rpm" \
    INSTALL_PECL="scrypt pgsql"

# RPM repos & packages
RUN yum install -y ${EXTRA_REPOS} && \
    for repo in "$ENABLE_REPOS"; do yum-config-manager --enable $repo; done && \
    ( [ -z "$REMOVE_PKGS" ] || yum remove -y ${REMOVE_PKGS} ) && \
    yum update -y && \
    yum clean all -y && rm -rf /var/cache/yum

RUN yum install -y --setopt=tsflags=nodocs ${INSTALL_PKGS} && \
    yum clean all -y && rm -rf /var/cache/yum

COPY ./contrib/ /opt/app-root/

# NewRelic
RUN NR_INSTALL_SILENT=1 newrelic-install install

# ffmpeg
RUN mkdir -p /tmp/ffmpeg && cd /tmp/ffmpeg && \
    curl -s http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar xzvf - && \
    cd ffmpeg-${FFMPEG_VERSION} && \
    ./configure --prefix="${FFMPEG_PREFIX}" --extra-cflags="-I${FFMPEG_PREFIX}/include" --extra-ldflags="-L${FFMPEG_PREFIX}/lib" --bindir="${FFMPEG_PREFIX}/bin" \
        --extra-libs=-ldl --enable-version3 --enable-gpl \
        --enable-postproc --enable-nonfree --enable-avresample --disable-debug --enable-small --disable-yasm && \
    make install && \
    rm -rf /tmp/ffmpeg

# phantomjs
RUN yum install -y $PHANTOMJS_URL && \
    yum clean all -y && rm -rf /var/cache/yum

# pecl
RUN pecl install --onlyreqdeps $INSTALL_PECL && \
    pecl clear-cache && \
    ( cd / && curl https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_x86_64.rpm | rpm2cpio | cpio -idvm )

# nodejs
RUN npm install gulp -g --save-dev && \
    chmod -R a+rwx $(npm root -g)

# TODO: Review - We may not need it since there is support for user defined config from s2i
RUN rm -rf /opt/rh/httpd24/root/var/run/httpd && \
    mkdir -p /opt/rh/httpd24/root/var/run/httpd && \
    chown -R 1001:0 /opt/app-root /tmp/sessions /var/cache/mod_pagespeed && \
    chmod -R 777 /var/cache/mod_pagespeed && \
    chmod -R ug+rwx /opt/app-root && \
    chmod -R a+rwx \
        /opt/rh/httpd24/root/etc/httpd/conf.d \
        /opt/rh/httpd24/root/var/run/httpd \
        /tmp/sessions \
        /var/cache/

RUN sed -i 's/memory_limit\s.*/memory_limit = -1/g'  $PHP_SYSCONF_PATH/php.ini

USER 1001

RUN npm link gulp --no-bin-links
