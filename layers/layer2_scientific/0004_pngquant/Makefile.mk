include ../../../adm/root.mk
include ../../package.mk

export NAME=pngquant
export VERSION=2.12.0
export EXTENSION=tar.gz
export CHECKTYPE=SHA1
export CHECKSUM=f57ce0112e86ac966c55270ccf5971deff241d4f
DESCRIPTION=\
PNGQUANT is a command-line utility and a library for lossy compression of PNG images
WEBSITE=http://www.pngquant.org/
LICENSE=GPL v3 or later with additional copyright notices for older parts of the code

all:: $(PREFIX)/bin/pngquant
$(PREFIX)/bin/pngquant:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure build install
