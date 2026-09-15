include ../../../adm/root.mk
include ../../package.mk

export NAME=hiredis
export VERSION=1.4.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=6e1641f85daf77ac716c9f87b3fc14ec
DESCRIPTION=\
Hiredis is a minimalistic C client library for the Redis database.
WEBSITE=https://redis.com/lp/hiredis/
LICENSE=BSD

all:: $(PREFIX)/lib/libhiredis.so.1.1.0
$(PREFIX)/lib/libhiredis.so.1.1.0:
	$(MAKE) --file=../../Makefile.standard download uncompress
	cd build/$(NAME)-$(VERSION) && make USE_SSL=1 OPENSSL_PREFIX=$(PREFIX) install
	rm -f $(PREFIX)/lib/libhiredis*.a
