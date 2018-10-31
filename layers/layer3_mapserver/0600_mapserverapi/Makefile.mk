include ../../../adm/root.mk
include ../../package.mk

export NAME=mapserverapi
export VERSION=0.1.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=ede7234828c6fd9e818de9a9f639b356
DESCRIPTION=\
tiny C library to invoke mapserver engine as a library
LICENSE=BSD

all::$(PREFIX)/lib/libmapserverapi.so
$(PREFIX)/lib/libmapserverapi.so:
	$(MAKE) --file=../../Makefile.standard MAKEOPT="PREFIX=$(PREFIX) MAPSERVER_LIB_DIR=$(PREFIX)/lib" download uncompress build install
