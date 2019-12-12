include ../../../adm/root.mk
include ../../package.mk

export NAME=cairo
export VERSION=1.17.2
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=321a07adaeb125cb5513079256d465fb
DESCRIPTION=\
Cairo is a 2D graphics library with support for multiple output devices.
WEBSITE=https://www.cairographics.org/
LICENSE=LGPL

all::$(PREFIX)/lib/libcairo.so
$(PREFIX)/lib/libcairo.so:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--disable-trace" download uncompress configure build install
