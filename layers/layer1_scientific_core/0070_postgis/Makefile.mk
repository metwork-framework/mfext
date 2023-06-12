include ../../../adm/root.mk
include ../../package.mk

export NAME=postgis
export VERSION=3.3.1
export SHORT_VERSION=3
# export EXTENSION (see below)
export CHECKTYPE=MD5
export CHECKSUM=d042e8fb879982233b5794bee3d3dd24
DESCRIPTION=\
PostGIS is a spatial database extender for PostgreSQL database.\
It adds support for geographic objects allowing location queries to be run\
in SQL.
WEBSITE=https://postgis.net
LICENSE=GPL

all:: $(PREFIX)/lib/postgresql/postgis-$(SHORT_VERSION).so $(PREFIX)/contrib/postgis-$(SHORT_VERSION)/postgis_comments.sql

$(PREFIX)/lib/postgresql/postgis-$(SHORT_VERSION).so:
# EXTENSION is an internal variable used by postgis, for us it is not used anymore after uncompress.
# So we split : "download uncompress" with EXTENSION and "configure build install" without it
	export EXTENSION=tar.gz ; $(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) configure build install

$(PREFIX)/contrib/postgis-$(SHORT_VERSION)/postgis_comments.sql:
	mkdir -p $(PREFIX)/contrib/postgis-$(SHORT_VERSION)
	cd build/$(NAME)-$(VERSION) && cp -f doc/postgis_comments.sql $(PREFIX)/contrib/postgis-$(SHORT_VERSION)/
