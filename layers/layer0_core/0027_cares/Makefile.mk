include ../../../adm/root.mk
include ../../package.mk

export NAME=c-ares
export VERSION=1.12.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=2ca44be1715cd2c5666a165d35788424
DESCRIPTION=\
C-ARES is a C library for asynchronous DNS requests (including name resolves)
WEBSITE=https://c-ares.haxx.se/
LICENSE=MIT

all::$(PREFIX)/lib/libcares.so
$(PREFIX)/lib/libcares.so:
	$(MAKE) --file=../../Makefile.standard download uncompress configure build install
