include ../../../adm/root.mk
include ../../package.mk

export NAME=libxslt
export VERSION=1.1.28
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=9667bf6f9310b957254fdcf6596600b7
DESCRIPTION=\
LIBXSLT est une bibliothèque en C de manipulations XSLT
WEBSITE=http://xmlsoft.org/
LICENSE=MIT

all:: $(PREFIX)/lib/libxslt.so
$(PREFIX)/lib/libxslt.so:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--enable-shared --disable-static --without-python" download uncompress configure build install
