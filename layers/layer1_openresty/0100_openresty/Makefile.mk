include ../../../adm/root.mk
include ../../package.mk

export NAME=openresty
export VERSION=1.11.2.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=f4b9aa960e57ca692c4d3da731b7e38b
DESCRIPTION=\
OPENRESTY est une distribution nginx qui ajoute des modules supplémentaires
WEBSITE=http://openresty.org
LICENSE=BSD
PCRE_SOURCE_PATH=`readlink -m ../../layer0_core/0110_pcre/build/pcre-8.36/`

all:: $(PREFIX)/bin/resty
$(PREFIX)/bin/resty:
	echo $(PCRE_SOURCE_PATH)
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--with-pcre=$(PCRE_SOURCE_PATH) --without-lua_resty_memcached --without-lua_resty_mysql --with-lua_resty_websocket --without-http_scgi_module --without-http_uwsgi_module --http-fastcgi-temp-path=/tmp --without-http_ssi_module --with-http_dav_module --with-http_sub_module --with-http_realip_module --with-http_stub_status_module --http-client-body-temp-path=/tmp/nginx_clientbody_temp --http-proxy-temp-path=/tmp/nginx_proxy_temp --with-threads" download uncompress configure build install
	if ! test -d $(PREFIX)/config; then mkdir -p $(PREFIX)/config; fi
	rm -f $(PREFIX)/config/mime.types && ln -s $(PREFIX)/nginx/conf/mime.types $(PREFIX)/config/mime.types
