include ../../../adm/root.mk
include ../../package.mk

export NAME=openresty
export VERSION=1.15.8.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=d614e17360e3a805ff94edbf7037221c
DESCRIPTION=\
OPENRESTY est une distribution nginx qui ajoute des modules supplémentaires
WEBSITE=http://openresty.org
LICENSE=BSD

all:: $(PREFIX)/bin/resty
$(PREFIX)/bin/resty:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRACFLAGS="-I$(PREFIX)/../core/include" EXTRALDFLAGS="-L$(PREFIX)/../core/lib" OPTIONS="--with-pcre --without-lua_resty_memcached --without-lua_resty_mysql --without-http_scgi_module --without-http_uwsgi_module --http-fastcgi-temp-path=/tmp --with-http_dav_module --with-http_sub_module --with-http_realip_module --with-http_stub_status_module --with-http_auth_request_module --http-client-body-temp-path=/tmp/nginx_clientbody_temp --http-proxy-temp-path=/tmp/nginx_proxy_temp --with-threads --error-log-path=stderr" download uncompress configure build install
	if ! test -d $(PREFIX)/config; then mkdir -p $(PREFIX)/config; fi
	rm -f $(PREFIX)/config/mime.types && ln -s $(PREFIX)/nginx/conf/mime.types $(PREFIX)/config/mime.types
