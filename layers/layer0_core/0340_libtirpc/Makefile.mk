include ../../../adm/root.mk
include ../../package.mk

export NAME=libtirpc
export VERSION=1.3.3
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=bacdad5c27dcf6e2830b3e26a1c8ed3f
DESCRIPTION=\
LIBTIRPC package contains libraries that support programs that use the Remote Procedure Call (RPC) API
WEBSITE=https://sourceforge.net/projects/libtirpc/
LICENSE=LGPL

all:: $(PREFIX)/lib/libtirpc.so
$(PREFIX)/lib/libtirpc.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--disable-static --disable-gssapi" download uncompress configure build install
