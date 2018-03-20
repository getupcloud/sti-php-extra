#!/bin/bash

export PCRE_ENABLE_JIT=${PCRE_ENABLE_JIT:-0} # http://php.net/manual/en/pcre.configuration.php#ini.pcre.jit
export ZEND_ASSERTIONS=${ZEND_ASSERTIONS:--1} # http://php.net/zend.assertions
export ASSERT_ACTIVE=${ASSERT_ACTIVE:-On} # http://php.net/assert.exception
export ENABLE_MULTISITE=${ENABLE_MULTISITE:-false}

if [ "${ENABLE_MULTISITE,,}" == "true" -o "${ENABLE_MULTISITE}" == 1 ]; then
    echo "--> Activating multisite"
    mv ${PHP_CONTAINER_SCRIPTS_PATH}/httpd-cnf/multisite.conf.deativated \
       ${PHP_CONTAINER_SCRIPTS_PATH}/httpd-cnf/multisite.conf
fi

for template in /opt/app-root/etc/php.d/*.template; do
    envsubst < ${template} > $PHP_INI_SCAN_DIR/$(basename ${template} .template)
done
