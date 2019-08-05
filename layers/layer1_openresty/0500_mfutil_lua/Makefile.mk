include ../../../adm/root.mk
include ../../package.mk

export NAME=mfutil_lua
export VERSION=0.0.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=bf6305f068b78cf3e08e2e4a437ed561
DESCRIPTION=\
MFUTIL_LUA is a lua binding of some parts of mfutil library.
WEBSITE=https://github.com/metwork-framework/mfutil_lua
LICENSE=BSD

all:: $(PREFIX)/lualib/resty/mfutil.lua

$(PREFIX)/lualib/resty/mfutil.lua: Makefile Makefile.mk sources
	$(MAKE) --file=../../Makefile.standard download uncompress
	cd build/$(NAME)-$(VERSION) && cp -f mfutil.lua $(PREFIX)/lualib/resty/
