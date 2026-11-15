include ../../../adm/root.mk
include ../../package.mk

export NAME=libevent
export VERSION=2.1.13
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=eaa0bd3472b5d6a52ac6b9e0b7418b03
DESCRIPTION=\
LIBVENT is an event notification library
WEBSITE=https://libevent.org/
LICENSE=BSD-3
EXPLICIT_NAME=$(NAME)-$(VERSION)-stable

all:: $(PREFIX)/lib/libevent.so
$(PREFIX)/lib/libevent.so: Makefile sources Makefile.mk
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME=$(EXPLICIT_NAME) OPTIONS="--disable-static" download uncompress configure build install
