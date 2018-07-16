include ../../../adm/root.mk
include ../../package.mk

export NAME=tcping
export VERSION=1.3.5
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=f9dd03c730db6999ca8beca479f078e3
DESCRIPTION=\
TCPING est un outil pour tester un port TCP (avec un timeout)
WEBSITE=http://linuxco.de
LICENSE=LGPL

all:: $(PREFIX)/bin/tcping
$(PREFIX)/bin/tcping:
	$(MAKE) --file=../../Makefile.standard download uncompress build
	cp -f build/$(NAME)-$(VERSION)/tcping $(PREFIX)/bin/tcping
