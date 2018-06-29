include ../../../adm/root.mk
include ../../package.mk

export NAME=lua-resty-http
export VERSION=master-20160530
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=3a9dbbe1e57cd5d866c1a415d9b479cc
DESCRIPTION=\
LUA_RESTY_HTTP est une bibliothèque HTTP pour LUA/OPENRESTY
WEBSITE=https://github.com/pintsized/lua-resty-http
LICENSE=BSD

all:: $(PREFIX)/lualib/resty/http.lua

$(PREFIX)/lualib/resty/http.lua:
	$(MAKE) --file=../../Makefile.standard download uncompress
	cd build/$(NAME)-$(VERSION) && cp -f lib/resty/http*.lua $(PREFIX)/lualib/resty/
