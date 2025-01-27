include ../../../adm/root.mk
include ../../package.mk

export NAME=libtirpc
export VERSION=1.3.6
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=8de9e6af16c4bc65ba40d0924745f5b7
DESCRIPTION=\
LIBTIRPC package contains libraries that support programs that use the Remote Procedure Call (RPC) API
WEBSITE=https://sourceforge.net/projects/libtirpc/
LICENSE=LGPL

all:: $(PREFIX)/lib/libtirpc.so
$(PREFIX)/lib/libtirpc.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--disable-static --disable-gssapi" download uncompress configure build install
