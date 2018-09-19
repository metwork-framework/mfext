include ../../../adm/root.mk
include ../../package.mk

export NAME=pcre
export VERSION=8.36
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=ff7b4bb14e355f04885cf18ff4125c98
DESCRIPTION=\
PCRE est une bibliothèque pour gérer les expressions régulières de type PERL
WEBSITE=http://www.pcre.org
LICENSE=BSD

all:: $(PREFIX)/lib/libpcre.so
$(PREFIX)/lib/libpcre.so:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--enable-shared --disable-static" download uncompress configure build install
