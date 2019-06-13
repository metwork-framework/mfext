include ../../../adm/root.mk
include ../../package.mk

export NAME=curl
export VERSION=7.65.1
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=7809378831d10fde18f9f6ae033cd3f3
DESCRIPTION=\
CURL is command line tool and library for transferring data with URLs
WEBSITE=https://curl.haxx.se/
LICENSE=MIT

all::$(PREFIX)/lib/libcurl.so
$(PREFIX)/lib/libcurl.so:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--without-libidn2 --disable-ipv6 --disable-tftp --disable-telnet --disable-dict --with-ssl --disable-ldaps --enable-crypto-auth --disable-sspi --disable-ldap --without-libssh2 --without-gnutls --without-nss --enable-ares=$(PREFIX)" download uncompress configure build install
