include ../../../adm/root.mk
include ../../package.mk

export NAME=ctags
export VERSION=5.8
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=c00f82ecdcc357434731913e5b48630d
DESCRIPTION=\
Ctags is a programming tool that generates an index (or tag) file of names found in source and header files of various programming languages.
WEBSITE=http://ctags.sourceforge.net/
LICENSE=GPL

all:: $(PREFIX)/bin/ctags
$(PREFIX)/bin/ctags:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--enable-shared --disable-static" download uncompress configure build install
