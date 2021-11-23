include ../../../adm/root.mk
include ../../package.mk

export NAME=libtiff
export VERSION=4.3.0
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=2f68582e2226e23df17042ba51f5aa01
DESCRIPTION=\
LIBTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.
WEBSITE=http://www.libtiff.org
LICENSE=https://spdx.org/licenses/libtiff.html
EXPLICIT_NAME=$(NAME)-v$(VERSION)

all:: $(PREFIX)/lib/libtiff.so.5
$(PREFIX)/lib/libtiff.so.5:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME=$(EXPLICIT_NAME) download uncompress configure_cmake build_cmake install_cmake
