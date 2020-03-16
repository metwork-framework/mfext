include ../../../adm/root.mk
include ../../package.mk

export NAME=freetype
export VERSION=2.10.1
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=bd42e75127f8431923679480efb5ba8f
DESCRIPTION=\
FreeType is a freely available software library to render fonts
WEBSITE=https://www.freetype.org/
LICENSE=GPL 2 or 3

all::$(PREFIX)/lib/libfreetype.so
$(PREFIX)/lib/libfreetype.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure build install

