include ../../../adm/root.mk
include ../../package.mk

export NAME=libpng
export VERSION=1.6.37
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=015e8e15db1eecde5f2eb9eb5b6e59e9
DESCRIPTION=\
LIBPNG is the official PNG reference library
WEBSITE=http://www.libpng.org/
LICENSE=Open Source : http://www.libpng.org/pub/png/src/libpng-LICENSE.txt

all:: $(PREFIX)/lib/libpng16.so
$(PREFIX)/lib/libpng16.so:
	# Since we build cmake in layer core, we could build libpng with cmake
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure build install
