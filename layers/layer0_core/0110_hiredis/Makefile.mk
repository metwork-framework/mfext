include ../../../adm/root.mk
include ../../package.mk

export NAME=hiredis
export VERSION=1.2.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=119767d178cfa79718a80c83e0d0e849
DESCRIPTION=\
Hiredis is a minimalistic C client library for the Redis database.
WEBSITE=https://redis.com/lp/hiredis/
LICENSE=BSD

all:: $(PREFIX)/lib/libhiredis.so.1.1.0
$(PREFIX)/lib/libhiredis.so.1.1.0:
	$(MAKE) --file=../../Makefile.standard download uncompress
	cd build/$(NAME)-$(VERSION) && make USE_SSL=1 OPENSSL_PREFIX=$(PREFIX) install
	rm -f $(PREFIX)/lib/libhiredis*.a
