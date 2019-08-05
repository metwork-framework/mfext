include ../../../adm/root.mk
include ../../package.mk

export NAME=libfastjson
export VERSION=0.99.8
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=730713ad1d851def7ac8898f751bbfdd
DESCRIPTION=\
a fast json library for C
WEBSITE=https://github.com/rsyslog/libfastjson
LICENSE=MIT

all:: $(PREFIX)/lib/libfastjson.so
$(PREFIX)/lib/libfastjson.so:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) download uncompress
	cd build/$(NAME)-$(VERSION) && sh autogen.sh --prefix=$(PREFIX)
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) configure build install
