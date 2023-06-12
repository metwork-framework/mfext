include ../../../adm/root.mk
include ../../package.mk

export NAME=autoconf
export VERSION=2.64
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=ef400d672005e0be21e0d20648169074
DESCRIPTION=\
Autoconf is an extensible package of M4 macros that produce shell scripts to automatically configure software source code packages
WEBSITE=https://www.gnu.org/software/autoconf
LICENSE=Gnu LGPL

all:: $(PREFIX)/bin/autoconf
$(PREFIX)/bin/autoconf:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure build install
