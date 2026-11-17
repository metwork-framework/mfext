include ../../../adm/root.mk
include ../../package.mk

export NAME=postgis
export VERSION=3.7.0
export SHORT_VERSION=3
# export EXTENSION (see below)
export CHECKTYPE=MD5
export CHECKSUM=dc4a19f64fa2149c61c46d85bf162405
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
	echo "trusted = true" >> $(PREFIX)/share/postgresql/extension/postgis.control
