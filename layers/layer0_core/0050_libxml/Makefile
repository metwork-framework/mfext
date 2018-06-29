include ../../../adm/root.mk
include ../../package.mk

export NAME=libxml2
export VERSION=2.9.7
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=896608641a08b465098a40ddf51cefba
DESCRIPTION=\
LIBXML est une bibliothèque en C de décodage XML
WEBSITE=http://xmlsoft.org/
LICENSE=MIT

all:: $(PREFIX)/lib/libxml2.so
$(PREFIX)/lib/libxml2.so:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--enable-shared --disable-static --with-python=$(PREFIX)" EXTRALDFLAGS="-L$(PREFIX)/lib" download uncompress configure build install
