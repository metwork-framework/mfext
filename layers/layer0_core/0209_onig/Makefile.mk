include ../../../adm/root.mk
include ../../package.mk

export NAME=onig
export VERSION=6.9.7
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=d39409a103dcd44425e37b88d642f22c
DESCRIPTION=\
Oniguruma is a modern and flexible regular expressions library. \
It encompasses features from different regular expression implementations \
that traditionally exist in different languages.
WEBSITE=https://github.com/kkos/oniguruma
LICENSE=BSD

all:: $(PREFIX)/lib/libonig.so
$(PREFIX)/lib/libonig.so:
	$(MAKE) --file=../../Makefile.standard download uncompress configure build install
