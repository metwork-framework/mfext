include ../../../adm/root.mk
include ../../package.mk

export NAME=mfutil_lua
export VERSION=0.0.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=a9d930400d627e6273102a30fbff40f2
DESCRIPTION=\
MFUTIL_LUA is a lua binding of some parts of mfutil library.
WEBSITE=https://github.com/metwork-framework/mfutil_lua
LICENSE=BSD

all:: $(PREFIX)/lualib/mfutil.lua

$(PREFIX)/lualib/mfutil.lua: Makefile Makefile.mk sources
	$(MAKE) --file=../../Makefile.standard download uncompress
	cd build/$(NAME)-$(VERSION) && cp -f mfutil.lua $(PREFIX)/lualib/
