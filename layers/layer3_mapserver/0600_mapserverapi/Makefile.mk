include ../../../adm/root.mk
include ../../package.mk

export NAME=mapserverapi
export VERSION=0.1.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=27fe3125eada16e995c58a10eee1a89a
DESCRIPTION=\
tiny C library to invoke mapserver engine as a library
LICENSE=BSD

all::$(PREFIX)/lib/libmapserverapi.so
$(PREFIX)/lib/libmapserverapi.so:
	$(MAKE) --file=../../Makefile.standard MAKEOPT="PREFIX=$(PREFIX) MAPSERVER_LIB_DIR=$(PREFIX)/lib" download uncompress build install
