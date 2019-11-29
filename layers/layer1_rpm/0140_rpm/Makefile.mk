include ../../../adm/root.mk
include ../../package.mk

export NAME=rpm
export VERSION=4.15.1
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=ed72147451a5ed93b2a48e2f8f5413c3
DESCRIPTION=\
RPM is a powerful command line driven package management
WEBSITE=http://rpm.org
LICENSE=GPL

NSPR_CFLAGS:=$(shell nspr-config --cflags nspr)
NSPR_LIBS:=$(shell nspr-config --libs nspr)
NSS_CFLAGS:=$(shell nss-config --cflags nss)
NSS_LIBS:=$(shell nss-config --libs nss)

all:: $(PREFIX)/bin/rpm
$(PREFIX)/bin/rpm:
	#-I$(PREFIX)/include is needed to find db includes (db.h) in the absence of db.pc
	$(MAKE) --file=../../Makefile.standard OPTIONS="--without-archive --without-selinux --without-lua --with-external-db --localstatedir=/var --bindir=$(PREFIX)/bin" EXTRALDFLAGS="-L$(PREFIX)/lib $(NSPR_LIBS) $(NSS_LIBS)" EXTRACFLAGS="-I$(PREFIX)/include $(NSPR_CFLAGS) $(NSS_CFLAGS)" download uncompress configure build
	cd build/$(NAME)-$(VERSION) && make install
	rm -f $(PREFIX)/bin/rpmquery $(PREFIX)/bin/rpmverify 
	ln -s $(PREFIX)/bin/rpm $(PREFIX)/bin/rpmquery
	ln -s $(PREFIX)/bin/rpm $(PREFIX)/bin/rpmverify
