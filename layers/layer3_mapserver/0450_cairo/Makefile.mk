include ../../../adm/root.mk
include ../../package.mk

export NAME=cairo
export VERSION=1.14.12
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=9f0db9dbfca0966be8acd682e636d165
DESCRIPTION=\
Cairo is a 2D graphics library with support for multiple output devices.
LICENSE=LGPL

all::$(PREFIX)/lib/libcairo.so
$(PREFIX)/lib/libcairo.so:
	$(MAKE) --file=../../Makefile.standard download uncompress configure build install
