include ../../../adm/root.mk
include ../../package.mk

export NAME=cyrus-sasl
export VERSION=2.1.28
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=6f228a692516f5318a64505b46966cfa
DESCRIPTION=\
This is the Cyrus SASL API implementation
WEBSITE=https://www.cyrusimap.org/sasl/
LICENSE=Carnegie Mellon University

all:: $(PREFIX)/lib/libsasl2.so
$(PREFIX)/lib/libsasl2.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--disable-static" download uncompress configure build install
