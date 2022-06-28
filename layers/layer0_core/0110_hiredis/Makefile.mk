include ../../../adm/root.mk
include ../../package.mk

export NAME=hiredis
export VERSION=1.0.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=58e8313188f66ed1be1c220d14a7752e
DESCRIPTION=\
Hiredis is a minimalistic C client library for the Redis database.
WEBSITE=https://redis.com/lp/hiredis/
LICENSE=BSD

all:: $(PREFIX)/lib/libhiredis.so.1.0.0
$(PREFIX)/lib/libhiredis.so.1.0.0:
	$(MAKE) --file=../../Makefile.standard download uncompress
	cd build/$(NAME)-$(VERSION) && make USE_SSL=1 install
