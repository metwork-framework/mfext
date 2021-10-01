include ../../../adm/root.mk
include ../../package.mk

export NAME=zeromq
export VERSION=4.3.4
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=c897d4005a3f0b8276b00b7921412379
DESCRIPTION=\
ZeroMQ is an open-source universal messaging library
WEBSITE=https://zeromq.org/
LICENSE=LGPL

all:: $(PREFIX)/lib/libzmq.so
$(PREFIX)/lib/libzmq.so: Makefile sources Makefile.mk
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--disable-static" download uncompress configure build install
