include ../../../adm/root.mk
include ../../package.mk

export NAME=redis
export VERSION=3.2.8
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=c91867a18ae0c5f7bb61a7c1120d80b4
DESCRIPTION=\
REDIS est un outil de cache semi-persistant \
du type MEMCACHED
WEBSITE=http://redis.io
LICENSE=BSD

all:: $(PREFIX)/bin/redis-cli
$(PREFIX)/bin/redis-cli:
	$(MAKE) --file=../../Makefile.standard download uncompress build install
	cd build/$(NAME)-$(VERSION) && cp -f redis.conf $(PREFIX)/share/
