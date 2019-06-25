include ../../../adm/root.mk
include ../../package.mk

export NAME=libressl
export VERSION=2.9.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=b3fa8935701af31c894c4d78f9a21f1c
DESCRIPTION=\
LibreSSL is a version of the TLS/crypto stack forked from OpenSSL in 2014
WEBSITE=https://www.libressl.org/
LICENSE=OpenSSL License + Original SSLeay License

all::$(PREFIX)/lib/libssl.so
$(PREFIX)/lib/libssl.so:
	$(MAKE) --file=../../Makefile.standard download uncompress configure build install
