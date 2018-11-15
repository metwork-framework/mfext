include ../../../adm/root.mk
include ../../package.mk

export NAME=postgis
export VERSION=2.4.4
export SHORT_VERSION=2.4
# export EXTENSION cf plus bas
export CHECKTYPE=MD5
export CHECKSUM=87608a7f01a50c5bae72a00ba3314e2d
DESCRIPTION=\
PostGIS is a spatial database extender for PostgreSQL database.\
It adds support for geographic objects allowing location queries to be run\
in SQL.
WEBSITE=http://postgis.refractions.net/
LICENSE=GPL

all:: $(PREFIX)/lib/postgis-$(SHORT_VERSION).so $(PREFIX)/contrib/postgis-$(SHORT_VERSION)/postgis_comments.sql

$(PREFIX)/lib/postgis-$(SHORT_VERSION).so:
# EXTENSION est une variable utilisée par postgis, pour nous elle ne sert sert plus après uncompress
# on coupe l'appel à make en deux : "download uncompress" avec EXTENSION et sans pour "configure build install"
	export EXTENSION=tar.gz ; $(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--with-projdir=$(PREFIX) --with-jsondir=$(PREFIX)/../core --with-pgconfig=$(PREFIX)/bin/pg_config --with-geosconfig=$(PREFIX)/bin/geos-config --with-gdalconfig=$(PREFIX)/bin/gdal-config" configure build install

$(PREFIX)/contrib/postgis-$(SHORT_VERSION)/postgis_comments.sql:
	mkdir -p $(PREFIX)/contrib/postgis-$(SHORT_VERSION)
	cd build/$(NAME)-$(VERSION) && cp -f doc/postgis_comments.sql $(PREFIX)/contrib/postgis-$(SHORT_VERSION)/
