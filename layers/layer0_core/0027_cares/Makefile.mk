include ../../../adm/root.mk
include ../../package.mk

export NAME=c-ares
export VERSION=1.15.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=d2391da274653f7643270623e822dff7
DESCRIPTION=\
C-ARES is a C library for asynchronous DNS requests (including name resolves)
WEBSITE=https://c-ares.haxx.se/
LICENSE=MIT

all::$(PREFIX)/lib/libcares.so
$(PREFIX)/lib/libcares.so:
	$(MAKE) --file=../../Makefile.standard download uncompress configure build install
