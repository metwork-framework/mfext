include ../../../adm/root.mk
include ../../package.mk

export NAME=openssl
export VERSION=3.4.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=fb7a747ac6793a7ad7118eaba45db379
DESCRIPTION=\
OpenSSL is a robust, commercial-grade, full-featured Open Source Toolkit for the TLS (formerly SSL), DTLS and QUIC protocols
WEBSITE=https://www.openssl.org/
LICENSE=Apache 2.0

all:: $(PREFIX)/lib/libssl.so
$(PREFIX)/lib/libssl.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--libdir=lib no-docs" download uncompress Configure build install
	rm -f $(PREFIX)/lib/libssl.a $(PREFIX)/lib/libcrypto.a
	cd $(PREFIX)/ssl && rm -f cert.pem && ln -s /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem cert.pem
