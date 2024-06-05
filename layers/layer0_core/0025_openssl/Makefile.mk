include ../../../adm/root.mk
include ../../package.mk

export NAME=openssl
export VERSION=3.3.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=8a4342b399c18f870ca6186299195984
DESCRIPTION=\
OpenSSL is a robust, commercial-grade, full-featured Open Source Toolkit for the TLS (formerly SSL), DTLS and QUIC protocols
WEBSITE=https://www.openssl.org/
LICENSE=Apache 2.0

all:: $(PREFIX)/lib/libssl.so
$(PREFIX)/lib/libssl.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--libdir=$(PREFIX)/lib" download uncompress Configure build install
	rm -f /usr/lib64/libssl.so /usr/lib64/libcrypto.so
	cd /usr/lib64 && ln -s $(PREFIX)/lib/libssl.so libssl.so && ln -s $(PREFIX)/lib/libcrypto.so libcrypto.so
