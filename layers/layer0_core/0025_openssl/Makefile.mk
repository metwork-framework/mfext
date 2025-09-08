include ../../../adm/root.mk
include ../../package.mk

export NAME=openssl
export VERSION=3.5.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=890fc59f86fc21b5e4d1c031a698dbde
DESCRIPTION=\
OpenSSL is a robust, commercial-grade, full-featured Open Source Toolkit for the TLS (formerly SSL), DTLS and QUIC protocols
WEBSITE=https://www.openssl.org/
LICENSE=Apache 2.0

all:: $(PREFIX)/lib/libssl.so
$(PREFIX)/lib/libssl.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--libdir=lib no-docs" download uncompress Configure build install
	rm -f $(PREFIX)/lib/libssl.a $(PREFIX)/lib/libcrypto.a
	cd $(PREFIX)/ssl && rm -f cert.pem && ln -s /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem cert.pem
