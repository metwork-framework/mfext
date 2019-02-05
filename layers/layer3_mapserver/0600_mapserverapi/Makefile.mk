include ../../../adm/root.mk
include ../../package.mk

export NAME=mapserverapi
export VERSION=0.1.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=59f3d9972521c41fe09945a1109c0c33
DESCRIPTION=\
tiny C library to invoke mapserver engine as a library
LICENSE=BSD

all::$(PREFIX)/lib/libmapserverapi.so
$(PREFIX)/lib/libmapserverapi.so:
	$(MAKE) --file=../../Makefile.standard MAKEOPT="PREFIX=$(PREFIX) MAPSERVER_LIB_DIR=$(PREFIX)/lib" download uncompress build install
