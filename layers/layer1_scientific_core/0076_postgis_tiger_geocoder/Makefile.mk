include ../../../adm/root.mk
include ../../package.mk

export NAME=postgis_tiger_geocoder
export VERSION=2025.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=19b408f8b7369a4782e875c7f497f8e0
export EXPLICIT_NAME=$(NAME)
DESCRIPTION=\
The postgis_tiger_geocoder is a PL/pgSQL extension that contains functions for geocoding, reverse geocoding, and standardizing address data using US Census TIGER/Line data
WEBSITE=https://gitea.osgeo.org/postgis/postgis_tiger_geocoder
LICENSE=GNU GPL

all:: $(PREFIX)/share/postgresql/extension/postgis_tiger_geocoder.sql

$(PREFIX)/share/postgresql/extension/postgis_tiger_geocoder.sql:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME=$(EXPLICIT_NAME) download uncompress build install
