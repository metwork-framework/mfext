include ../../../adm/root.mk
include ../../package.mk

export NAME=openresty
export VERSION=1.15.8.4
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=819a31fa6e9cc8c5aa4838384a9717a7
DESCRIPTION=\
OpenResty - Turning Nginx into a Full-Fledged Scriptable Web Platform
WEBSITE=http://openresty.org
LICENSE=BSD

#Version 1.15.8.4 does not exist : it's 1.15.8.3 with patch on CVE-2020-11724
export SOURCE_VERSION=1.15.8.3
export EXPLICIT_NAME=$(NAME)-$(SOURCE_VERSION)

export SSL_CFLAGS+=$(shell pkg-config --cflags openssl)
export SSL_LDFLAGS+=$(shell pkg-config --libs openssl)

all:: $(PREFIX)/bin/resty
$(PREFIX)/bin/resty:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME="$(EXPLICIT_NAME)" EXTRACFLAGS="$(SSL_CFLAGS)" EXTRALDFLAGS="$(SSL_LDFLAGS)" OPTIONS=" --with-pcre --without-lua_resty_memcached --without-lua_resty_mysql --without-http_scgi_module --without-http_uwsgi_module --http-fastcgi-temp-path=/tmp --with-http_dav_module --with-http_sub_module --with-http_realip_module --with-http_stub_status_module --with-http_auth_request_module --http-client-body-temp-path=/tmp/nginx_clientbody_temp --http-proxy-temp-path=/tmp/nginx_proxy_temp --with-threads --error-log-path=stderr" download uncompress configure build install
	if ! test -d $(PREFIX)/config; then mkdir -p $(PREFIX)/config; fi
	rm -f $(PREFIX)/config/mime.types && ln -s $(PREFIX)/nginx/conf/mime.types $(PREFIX)/config/mime.types
