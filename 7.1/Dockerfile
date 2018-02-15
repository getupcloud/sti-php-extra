FROM centos/php-71-centos7:latest

MAINTAINER Mateus Caruccio <mateus.caruccio@getupcloud.com>

USER root

ENV EXTRA_REPOS="http://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm \
        https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm" \
    INSTALL_PKGS="glibc-common  rh-php70-php-devel newrelic-php5 sclo-php70-php-* nodejs" \
    REMOVE_PKGS="rh-nodejs6-*" \
    FFMPEG_VERSION="3.4.1" \
    FFMPEG_PREFIX="/usr/local"

# RPM repos & packages
RUN curl -s https://rpm.nodesource.com/setup_9.x | bash - && \
    yum install -y ${EXTRA_REPOS} && \
    ( [ -z "$REMOVE_PKGS" ] || yum remove -y ${REMOVE_PKGS} ) && \
    yum update -y && \
    yum install -y --setopt=tsflags=nodocs ${INSTALL_PKGS} && \
    yum clean all -y

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

# phantonjs
RUN curl -Ls https://github.com/ariya/phantomjs/releases/download/2.1.3/phantomjs > /usr/local/bin/phantomjs && \
    chmod +x /usr/local/bin/phantomjs

# pecl
RUN INSTALL_PECL="scrypt uuid xdebug pgsql" && \
    pecl install --onlyreqdeps $INSTALL_PECL && \
    pecl clear-cache && \
    ( cd / && curl https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_x86_64.rpm | rpm2cpio | cpio -idvm )

# nodejs
RUN npm install gulp -g

COPY ./contrib/ /opt/app-root/

# TODO: Review - We may not need it since there is support for user defined config from s2i
RUN rm -rf /opt/rh/httpd24/root/var/run/httpd && \
    mkdir -p /opt/rh/httpd24/root/var/run/httpd && \
    chown -R 1001:0 /opt/app-root /tmp/sessions && \
    chmod -R ug+rwx /opt/app-root && \
    chmod -R a+rwx \
        /opt/rh/httpd24/root/etc/httpd/conf.d \
        /opt/rh/httpd24/root/var/run/httpd \
        /tmp/sessions

USER 1001
