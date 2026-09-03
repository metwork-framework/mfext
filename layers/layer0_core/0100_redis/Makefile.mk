include ../../../adm/root.mk
include ../../package.mk

export NAME=redis
export VERSION=7.4.10
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=bb6c18529d323ccbf1baa5c3f517a60c
DESCRIPTION=\
REDIS is an in-memory data structure store, used as a database, cache \
and message broker
WEBSITE=http://redis.io
LICENSE=BSD

all:: $(PREFIX)/bin/redis-cli
$(PREFIX)/bin/redis-cli:
	$(MAKE) --file=../../Makefile.standard download uncompress build install
	cd build/$(NAME)-$(VERSION) && cp -f redis.conf $(PREFIX)/share/
