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
PCRE_SOURCE_PATH=$(LAYER_DIR)/pcre/build/pcre
LIBRESSL_SOURCE_PATH=$(LAYER_DIR)/libressl/build/libressl
NGINX_UPLOAD_MODULE_SOURCE_PATH=$(LAYER_DIR)/nginx-upload-module/build/nginx-upload-module-2.3.0

all:: $(PREFIX)/bin/resty
$(PREFIX)/bin/resty: $(PCRE_SOURCE_PATH) $(LIBRESSL_SOURCE_PATH) $(NGINX_UPLOAD_MODULE_SOURCE_PATH)
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRACFLAGS="-I$(PREFIX)/../core/include" EXTRALDFLAGS="-L$(PREFIX)/../core/lib" OPTIONS="--add-module=$(NGINX_UPLOAD_MODULE_SOURCE_PATH) --with-pcre=$(PCRE_SOURCE_PATH) --with-openssl=$(LIBRESSL_SOURCE_PATH) --without-lua_resty_memcached --without-lua_resty_mysql --without-http_scgi_module --without-http_uwsgi_module --http-fastcgi-temp-path=/tmp --without-http_ssi_module --with-http_dav_module --with-http_sub_module --with-http_realip_module --with-http_stub_status_module --with-http_auth_request_module --http-client-body-temp-path=/tmp/nginx_clientbody_temp --http-proxy-temp-path=/tmp/nginx_proxy_temp --with-threads --error-log-path=stderr" download uncompress configure build install
	if ! test -d $(PREFIX)/config; then mkdir -p $(PREFIX)/config; fi
	rm -f $(PREFIX)/config/mime.types && ln -s $(PREFIX)/nginx/conf/mime.types $(PREFIX)/config/mime.types

$(PCRE_SOURCE_PATH):
	cd ../pcre && make downloadonly

$(LIBRESSL_SOURCE_PATH):
	cd ../libressl && make downloadonly

$(NGINX_UPLOAD_MODULE_SOURCE_PATH):
	cd ../nginx-upload-module && make

clean::
	cd ../pcre && make clean
	cd ../libressl && make clean
