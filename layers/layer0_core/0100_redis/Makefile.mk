include ../../../adm/root.mk
include ../../package.mk

export NAME=redis
export VERSION=5.0.14
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=406a4ddbdf0b60b4f288bf0c3cb06933
DESCRIPTION=\
REDIS is an in-memory data structure store, used as a database, cache \
and message broker
WEBSITE=http://redis.io
LICENSE=BSD

all:: $(PREFIX)/bin/redis-cli
$(PREFIX)/bin/redis-cli:
	$(MAKE) --file=../../Makefile.standard download uncompress build install
	cd build/$(NAME)-$(VERSION) && cp -f redis.conf $(PREFIX)/share/
