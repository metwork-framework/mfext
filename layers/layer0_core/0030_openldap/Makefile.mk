include ../../../adm/root.mk
include ../../package.mk

export NAME=openldap
export VERSION=2.6.9
export EXTENSION=tgz
export CHECKTYPE=MD5
export CHECKSUM=608973c35cd4924fca0f07d0ea72c016
DESCRIPTION=\
OpenLDAP is an open source implementation of the Lightweight Directory Access Protocol
WEBSITE=https://www.openldap.org/
LICENSE=OpenLDAP Public License

all:: $(PREFIX)/lib/libldap.so
$(PREFIX)/lib/libldap.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRACFLAGS="-I$(PREFIX)/include -I$(PREFIX)/include/openssl" EXTRALDFLAGS="-L$(PREFIX)/lib" OPTIONS="--disable-static" download uncompress configure build install
