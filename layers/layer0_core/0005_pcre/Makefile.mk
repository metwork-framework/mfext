include ../../../adm/root.mk
include ../../package.mk

export NAME=pcre
export VERSION=8.43
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=e775489c9f024a92ca0f431301ef4c5c
DESCRIPTION=\
The PCRE library is a set of functions that implement regular expression pattern matching using the same syntax and semantics as Perl 5
WEBSITE=http://www.pcre.org
LICENSE=BSD

all:: $(PREFIX)/lib/libpcre.so
$(PREFIX)/lib/libpcre.so: Makefile sources Makefile.mk
	$(MAKE) --file=../../Makefile.standard OPTIONS="--enable-shared --disable-static --enable-unicode-properties" download uncompress configure build install
