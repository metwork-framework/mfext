include ../../../adm/root.mk
include ../../package.mk

export NAME=zeromq
export VERSION=4.3.5
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=ae933b1e98411fd7cb8309f9502d2737
DESCRIPTION=\
ZeroMQ is an open-source universal messaging library
WEBSITE=https://zeromq.org/
LICENSE=LGPL

all:: $(PREFIX)/lib/libzmq.so
$(PREFIX)/lib/libzmq.so: Makefile sources Makefile.mk
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--disable-static" download uncompress configure build install
