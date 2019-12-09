include ../../../adm/root.mk
include ../../package.mk

export NAME=postgis
export VERSION=3.0.0
export SHORT_VERSION=2.4
# export EXTENSION (see below)
export CHECKTYPE=MD5
export CHECKSUM=725019e3a67ac52ccef4d00031cb0c77
DESCRIPTION=\
PostGIS is a spatial database extender for PostgreSQL database.\
It adds support for geographic objects allowing location queries to be run\
in SQL.
WEBSITE=http://postgis.refractions.net/
LICENSE=GPL

all:: $(PREFIX)/lib/postgresql/postgis-$(SHORT_VERSION).so $(PREFIX)/contrib/postgis-$(SHORT_VERSION)/postgis_comments.sql

$(PREFIX)/lib/postgresql/postgis-$(SHORT_VERSION).so:
# EXTENSION is an internal variable used by postgis, for us it is not used anymore after uncompress.
# So we split : "download uncompress" with EXTENSION and "configure build install" without it
	export EXTENSION=tar.gz ; $(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--with-projdir=$(PREFIX) --with-jsondir=$(PREFIX)/../core --with-pgconfig=$(PREFIX)/bin/pg_config --with-geosconfig=$(PREFIX)/bin/geos-config --with-gdalconfig=$(PREFIX)/bin/gdal-config" configure build install

$(PREFIX)/contrib/postgis-$(SHORT_VERSION)/postgis_comments.sql:
	mkdir -p $(PREFIX)/contrib/postgis-$(SHORT_VERSION)
	cd build/$(NAME)-$(VERSION) && cp -f doc/postgis_comments.sql $(PREFIX)/contrib/postgis-$(SHORT_VERSION)/
