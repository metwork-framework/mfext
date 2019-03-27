include ../../../adm/root.mk
include ../../package.mk

export NAME=ImageMagick6
export VERSION=6.9.9-51
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=45c5af7a18c858f3d72eff60f2a9b92a
export ARCHIV=$(VERSION).$(EXTENSION)
DESCRIPTION=\
IMAGEMAGICK is a software suite to create, edit, compose, or convert images.
WEBSITE=http://www.imagemagick.org
LICENSE=Apache 2.0

all:: $(PREFIX)/bin/convert
$(PREFIX)/bin/convert:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) ARCHIV=$(ARCHIV) OPTIONS="--disable-static" download uncompress configure build install
