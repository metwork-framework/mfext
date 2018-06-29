include ../../../adm/root.mk
include ../../package.mk

export NAME=lua-resty-cookie
export VERSION=master-20160630
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=225e187a3f6dfa694f55a20f2d8509f2
DESCRIPTION=\
LUA_RESTY_COOKIE est une bibliothèque COOKIE pour LUA/OPENRESTY
WEBSITE=https://github.com/cloudflare/lua-resty-cookie/
LICENSE=BSD

all:: $(PREFIX)/lualib/resty/cookie.lua

$(PREFIX)/lualib/resty/cookie.lua:
	$(MAKE) --file=../../Makefile.standard download uncompress
	cd build/$(NAME)-$(VERSION) && cp -f lib/resty/cookie.lua $(PREFIX)/lualib/resty/
