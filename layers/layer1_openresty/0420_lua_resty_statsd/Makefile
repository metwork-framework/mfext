include ../../../adm/root.mk
include ../../package.mk

export NAME=lua-resty-statsd
export VERSION=0.0.3
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=938d330f9661efcb4528b75b2ba8de5a
DESCRIPTION=\
LUA_RESTY_STATSD is a statsd client for openresty.
WEBSITE=https://github.com/metwork-framework/lua-resty-statsd
LICENSE=unknown

all:: $(PREFIX)/lualib/resty/statsd.lua

$(PREFIX)/lualib/resty/statsd.lua:
	$(MAKE) --file=../../Makefile.standard download uncompress
	cd build/$(NAME)-$(VERSION) && cp -f lib/resty/statsd.lua $(PREFIX)/lualib/resty/
