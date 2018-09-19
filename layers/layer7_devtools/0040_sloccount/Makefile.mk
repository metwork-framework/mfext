include ../../../adm/root.mk
include ../../package.mk

export NAME=sloccount
export VERSION=2.26
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=09abd6e2a016ebaf7552068a1dba1249
DESCRIPTION=\
A set of tools for counting physical Source Lines of Code (SLOC) 
WEBSITE=https://www.dwheeler.com/sloccount/
LICENSE=GPL

all:: $(PREFIX)/bin/sloccount
$(PREFIX)/bin/sloccount:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress build install
