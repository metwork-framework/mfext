include ../../../adm/root.mk
include ../../package.mk

export NAME=libev
export VERSION=4.25
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=911daf566534f745726015736a04f04a
DESCRIPTION=\
A full-featured and high-performance event loop library (in C).
WEBSITE=http://software.schmorp.de/pkg/libev.html
LICENSE=BSD

all::$(PREFIX)/lib/libev.so
$(PREFIX)/lib/libev.so:
	$(MAKE) --file=../../Makefile.standard download uncompress configure build install
