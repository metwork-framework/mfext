include ../../../adm/root.mk
include ../../package.mk

export NAME=lua-resty-hmac
export VERSION=master20190920
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=897b94ec0301c04589a99deea27a074a
DESCRIPTION=\
LUA_RESTY_HMAC if a HMAC lib for openresty
WEBSITE=https://github.com/jkeys089/lua-resty-hmac
LICENSE=BSD

all:: $(PREFIX)/lualib/resty/hmac.lua

$(PREFIX)/lualib/resty/hmac.lua:
	$(MAKE) --file=../../Makefile.standard download uncompress
	cd build/$(NAME)-$(VERSION) && cp -f lib/resty/hmac.lua $(PREFIX)/lualib/resty/
