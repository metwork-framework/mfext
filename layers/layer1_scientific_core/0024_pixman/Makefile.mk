include ../../../adm/root.mk
include ../../package.mk

export NAME=pixman
export VERSION=0.38.4
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=267a7af290f93f643a1bc74490d9fdd1
DESCRIPTION=\
Pixman is a low-level software library for pixel manipulation, providing features such as image compositing and trapezoid rasterization
WEBSITE=http://www.pixman.org/
LICENSE=MIT

all::$(PREFIX)/lib/libpixman-1.so
$(PREFIX)/lib/libpixman-1.so:
	$(MAKE) --file=../../Makefile.standard download uncompress configure build install
