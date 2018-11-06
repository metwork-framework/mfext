include ../../../adm/root.mk
include ../../package.mk

export NAME=postgis
export VERSION=2.4.4
export SHORT_VERSION=2.4
# export EXTENSION cf plus bas
export CHECKTYPE=MD5
export CHECKSUM=87608a7f01a50c5bae72a00ba3314e2d
# Option with-pgconfig is (mostly) forcing postgis install directory under postgresql install directory
# So we use PREFIX_PG rather than PREFIX (complete postgis install in postgresql layer)
export PREFIX_PG=$(PREFIX)/../postgresql
DESCRIPTION=\
PostGIS is a spatial database extender for PostgreSQL database.\
It adds support for geographic objects allowing location queries to be run\
in SQL.
WEBSITE=http://postgis.refractions.net/
LICENSE=GPL

all:: $(PREFIX_PG)/lib/postgis-$(SHORT_VERSION).so $(PREFIX_PG)/contrib/postgis-$(SHORT_VERSION)/postgis_comments.sql

$(PREFIX_PG)/lib/postgis-$(SHORT_VERSION).so:
# EXTENSION est une variable utilisée par postgis, pour nous elle ne sert sert plus après uncompress
# on coupe l'appel à make en deux : "download uncompress" avec EXTENSION et sans pour "configure build install"
	export EXTENSION=tar.gz ; $(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX_PG) OPTIONS="--with-projdir=$(PREFIX)/../scientific --with-jsondir=$(PREFIX)/../core --with-pgconfig=$(PREFIX_PG)/bin/pg_config --with-geosconfig=$(PREFIX)/../scientific/bin/geos-config --with-gdalconfig=$(PREFIX)/../scientific/bin/gdal-config" configure build install

$(PREFIX_PG)/contrib/postgis-$(SHORT_VERSION)/postgis_comments.sql:
	mkdir -p $(PREFIX_PG)/contrib/postgis-$(SHORT_VERSION)
	cd build/$(NAME)-$(VERSION) && cp -f doc/postgis_comments.sql $(PREFIX_PG)/contrib/postgis-$(SHORT_VERSION)/
