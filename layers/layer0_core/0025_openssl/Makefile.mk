include ../../../adm/root.mk
include ../../package.mk

export NAME=openssl
<<<<<<< HEAD
export VERSION=3.4.6
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=b1c938af7dd990bd53c63bc24269556c
=======
export VERSION=3.6.5
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=e1df3c3fea55e3dc8bcb6b422f436fbc
>>>>>>> 6e9de77 (feat: bump openssl from 3.6.4 to 3.6.5 (fix high CVE-2026-84782) (#2956))
DESCRIPTION=\
OpenSSL is a robust, commercial-grade, full-featured Open Source Toolkit for the TLS (formerly SSL), DTLS and QUIC protocols
WEBSITE=https://www.openssl.org/
LICENSE=Apache 2.0

all:: $(PREFIX)/lib/libssl.so
$(PREFIX)/lib/libssl.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--libdir=lib no-docs" download uncompress Configure build install
	rm -f $(PREFIX)/lib/libssl.a $(PREFIX)/lib/libcrypto.a
	cd $(PREFIX)/ssl && rm -f cert.pem && ln -s /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem cert.pem
