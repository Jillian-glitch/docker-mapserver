#!/bin/bash

#Install libharfbuzz from source as it is not in a repository
if [[ ! -f /tmp/resources/curl-7.50.0.tar.gz ]]; then \
  wget -c https://curl.haxx.se/download/curl-7.50.0.tar.gz -P /tmp/resources/; \
fi;\
cd /tmp/resources && \
tar -zxvf curl-7.50.0.tar.gz && \
cd curl-7.50.0 && \
./configure --with-ssl=/usr/local/ssl --enable-ares --enable-versioned-symbols && \
make -j 4 install

#export PYCURL_SSL_LIBRARY=openssl;export PYCURL_CURL_CONFIG=/usr/local/bin/curl-config
#export LD_LIBRARY_PATH=/usr/local/lib
ldconfig
#export PYCURL_SSL_LIBRARY=openssl
#export PYCURL_CURL_CONFIG=/usr/local/bin/curl-config
#export LD_LIBRARY_PATH=/usr/local/lib

pip3 install --compile pycurl
#Install libharfbuzz from source as it is not in a repository

VERSION=2.6.4
if [ ! -f /tmp/resources/harfbuzz-${VERSION}.tar.xz ]; then \
    wget -c https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-${VERSION}.tar.xz -P /tmp/resources/; \
    fi; \
    cd /tmp/resources &&\
    tar -xf harfbuzz-${VERSION}.tar.xz  &&\
    cd harfbuzz-${VERSION} && \
    ./configure  && \
    make -j 4 && \
    make install  && \
    ldconfig

# TODO add in the compile --with-curl-config=/usr/bin/curl-config \
if [  ! -d /tmp/resources/mapserver ]; then \
    git clone https://github.com/mapserver/mapserver /tmp/resources/mapserver; \
    fi;\
    mkdir -p /tmp/resources/mapserver/build && \
    cd /tmp/resources/mapserver/build && \
    cmake /tmp/resources/mapserver/ -DWITH_THREAD_SAFETY=1 \
        -DWITH_PROJ=1 \
        -DWITH_KML=1 \
        -DWITH_SOS=1 \
        -DWITH_WMS=1 \
        -DWITH_FRIBIDI=1 \
        -DWITH_HARFBUZZ=1 \
        -DWITH_ICONV=1 \
        -DWITH_CAIRO=1 \
        -DWITH_RSVG=1 \
        -DWITH_MYSQL=1 \
        -DWITH_GEOS=1 \
        -DWITH_POSTGIS=1 \
        -DWITH_GDAL=1 \
        -DWITH_OGR=1 \
        -DWITH_CURL=1 \
        -DWITH_CLIENT_WMS=1 \
        -DWITH_CLIENT_WFS=1 \
        -DWITH_WFS=1 \
        -DWITH_WCS=1 \
        -DWITH_LIBXML2=1 \
        -DWITH_GIF=1 \
        -DWITH_EXEMPI=1 \
        -DWITH_XMLMAPFILE=1 \
        -DWITH_PHP=ON \
        -DWITH_PYTHON=ON \
        -DWITH_PERL=ON \
        -DWITH_PROTOBUFC=0 \
        -DWITH_FCGI=0 && \
    make && \
    make install && \
    ldconfig

echo "ServerName localhost" >> /etc/apache2/apache2.conf
echo '<?php phpinfo();' > /var/www/html/info.php


 







