include ../../../adm/root.mk
include ../../package.mk

export NAME=lua-resty-statsd
export VERSION=0.0.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=b0eda67bc7e488aab4a3e33b02aa4c77
DESCRIPTION=\
LUA_RESTY_STATSD is a statsd client for openresty.
WEBSITE=https://github.com/metwork-framework/lua-resty-statsd
LICENSE=unknown

all:: $(PREFIX)/lualib/resty/statsd.lua

$(PREFIX)/lualib/resty/statsd.lua:
	$(MAKE) --file=../../Makefile.standard download uncompress
	cd build/$(NAME)-$(VERSION) && cp -f lib/resty/statsd.lua $(PREFIX)/lualib/resty/
