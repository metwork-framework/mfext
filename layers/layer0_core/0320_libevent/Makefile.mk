include ../../../adm/root.mk
include ../../package.mk

export NAME=libevent
export VERSION=2.1.12
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=b5333f021f880fe76490d8a799cd79f4
DESCRIPTION=\
LIBVENT is an event notification library
WEBSITE=https://libevent.org/
LICENSE=BSD-3
EXPLICIT_NAME=$(NAME)-$(VERSION)-stable

all:: $(PREFIX)/lib/libevent.so
$(PREFIX)/lib/libevent.so: Makefile sources Makefile.mk
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME=$(EXPLICIT_NAME) OPTIONS="--disable-static" download uncompress configure build install
