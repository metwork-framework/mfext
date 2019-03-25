include ../adm/root.mk
include ../adm/subdir_root.mk

export NAME=pcre
export VERSION=8.36
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=ff7b4bb14e355f04885cf18ff4125c98
DESCRIPTION=\
The PCRE library is a set of functions that implement regular expression pattern matching using the same syntax and semantics as Perl 5
WEBSITE=http://www.pcre.org
LICENSE=BSD


all:: $(MFEXT_HOME)/lib/libpcre.so
$(MFEXT_HOME)/lib/libpcre.so:
	$(MAKE) --file=../layers/Makefile.standard PREFIX=$(MFEXT_HOME) OPTIONS="--enable-shared --disable-static --enable-unicode-properties" download uncompress configure build install
