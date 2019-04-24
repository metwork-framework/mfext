include ../../../adm/root.mk
include ../../package.mk

export NAME=curl
export VERSION=7.53.1
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=fb1f03a142236840c1a77c035fa4c542
DESCRIPTION=\
CURL is command line tool and library for transferring data with URLs
WEBSITE=https://curl.haxx.se/
LICENSE=MIT

all::$(PREFIX)/lib/libcurl.so
$(PREFIX)/lib/libcurl.so:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--without-libidn2 --disable-ipv6 --disable-tftp --disable-telnet --disable-dict --with-ssl --disable-ldaps --enable-crypto-auth --disable-sspi --disable-ldap --without-libssh2 --without-gnutls --without-nss --enable-ares=$(PREFIX)" download uncompress configure build install
