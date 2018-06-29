include ../../../adm/root.mk
include ../../package.mk

export NAME=postgis
export VERSION=2.4.1
export SHORT_VERSION=2.4
# export EXTENSION cf plus bas
export CHECKTYPE=MD5
export CHECKSUM=d5f9444fbbddb6a33fabc106d67703b9
DESCRIPTION=\
POSTGIS est une extention spatiale pour le SGBDR PostgreSQL
WEBSITE=http://postgis.refractions.net/
LICENSE=GPL

all:: $(PREFIX)/lib/postgis-$(SHORT_VERSION).so $(PREFIX)/contrib/postgis-$(SHORT_VERSION)/postgis_comments.sql

$(PREFIX)/lib/postgis-$(SHORT_VERSION).so:
# EXTENSION est une variable utilisée par postgis, pour nous elle ne sert sert plus après uncompress
# on coupe l'appel à make en deux : "download uncompress" avec EXTENSION et sans pour "configure build install"
	export EXTENSION=tar.gz ; $(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress
	layer_wrapper --layers=scientific@mfext -- $(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--with-projdir=$(PREFIX)/../scientific --with-pgconfig=$(PREFIX)/bin/pg_config --with-geosconfig=$(PREFIX)/../scientific/bin/geos-config --with-gdalconfig=$(PREFIX)/../scientific/bin/gdal-config" configure build install

$(PREFIX)/contrib/postgis-$(SHORT_VERSION)/postgis_comments.sql:
	mkdir -p $(PREFIX)/contrib/postgis-$(SHORT_VERSION)
	cd build/$(NAME)-$(VERSION) && cp -f doc/postgis_comments.sql $(PREFIX)/contrib/postgis-$(SHORT_VERSION)/
