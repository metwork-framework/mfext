include ../../../adm/root.mk
include ../../package.mk

export NAME=libxslt
export VERSION=1.1.34
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=db8765c8d076f1b6caafd9f2542a304a
DESCRIPTION=\
LIBXSLT is the XSLT C library developed for the GNOME project. XSLT itself is a an XML language to define transformation for XML.
WEBSITE=http://xmlsoft.org/XSLT/
LICENSE=MIT

all:: $(PREFIX)/lib/libxslt.so
$(PREFIX)/lib/libxslt.so:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--enable-shared --disable-static --without-python" download uncompress configure build install
