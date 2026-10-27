include ../../../adm/root.mk
include ../../package.mk

export NAME=curl
export VERSION=8.22.0
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=3f6862e123fa4203667d1253ceb2d89c
DESCRIPTION=\
CURL is command line tool and library for transferring data with URLs
WEBSITE=https://curl.haxx.se/
LICENSE=MIT

all:: $(PREFIX)/lib/libcurl.so
$(PREFIX)/lib/libcurl.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRACFLAGS="-I$(PREFIX)/include" EXTRALDFLAGS="-L$(PREFIX)/lib" OPTIONS="--disable-static --without-libidn2 --disable-ipv6 --disable-tftp --disable-telnet --disable-dict --with-ssl --enable-ldaps --enable-crypto-auth --disable-sspi --enable-ldap --without-libssh2 --without-gnutls --without-nss" download uncompress configure build install
