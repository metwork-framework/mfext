include ../../../adm/root.mk
include ../../package.mk

export NAME=libtree
export VERSION=3.1.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=03d64114e732a7e0a7fcb32ab3562ffb
DESCRIPTION=\
A tool that turns ldd into a tree and explains how shared libraries are found or why they cannot be located
WEBSITE=https://github.com/haampie/libtree
LICENSE=MIT

all:: $(PREFIX)/bin/libtree
$(PREFIX)/bin/libtree:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress build
	cd build/$(NAME)-$(VERSION) && cp libtree $(PREFIX)/bin
