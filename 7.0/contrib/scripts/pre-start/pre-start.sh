#!/bin/bash

export PCRE_ENABLE_JIT=${PCRE_ENABLE_JIT:-0} # http://php.net/manual/en/pcre.configuration.php#ini.pcre.jit
export ZEND_ASSERTIONS=${ZEND_ASSERTIONS:--1} # http://php.net/zend.assertions
export ASSERT_ACTIVE=${ASSERT_ACTIVE:-On} # http://php.net/assert.exception
export PHP_MEMORY_LIMIT=${PHP_MEMORY_LIMIT:-256M}

for template in /opt/app-root/etc/php.d/*.template; do
    envsubst < ${template} > $PHP_INI_SCAN_DIR/$(basename ${template} .template)
done
