include ../../../adm/root.mk
include ../../package.mk

export NAME=libestr
export VERSION=0.1.11
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=8690d93478746e66a6d1f3eec8bba331
DESCRIPTION=\
essentials for string handling in C
WEBSITE=https://github.com/rsyslog/libestr
LICENSE=LGPL

all:: $(PREFIX)/lib/libestr.so
$(PREFIX)/lib/libestr.so:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	cd build/$(NAME)-$(VERSION) && sh autogen.sh --prefix=$(PREFIX)
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) configure build install
