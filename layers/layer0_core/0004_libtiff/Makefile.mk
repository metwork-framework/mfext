include ../../../adm/root.mk
include ../../package.mk

export NAME=libtiff
export VERSION=4.7.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=3a0fa4a270a4a192b08913f88d0cfbdd
DESCRIPTION=\
LIBTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data
WEBSITE=http://www.libtiff.org
LICENSE=https://spdx.org/licenses/libtiff.html
EXPLICIT_NAME=tiff-$(VERSION)

all:: $(PREFIX)/lib/libtiff.so.6
$(PREFIX)/lib/libtiff.so.6:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME=$(EXPLICIT_NAME) download uncompress configure_cmake build_cmake install_cmake
