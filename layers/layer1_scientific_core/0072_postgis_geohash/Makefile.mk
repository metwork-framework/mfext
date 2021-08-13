include ../../../adm/root.mk
include ../../package.mk

export NAME=postgis-geohash
export VERSION=0.2.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=434f2bd9ff93de9a0d901d1901d4cbc3
DESCRIPTION=\
Postgis Geohash is a PostGreSQL/Postgis extension to calculate per bit precision geohash
WEBSITE=https://github.com/adelplanque/postgis-geohash
LICENSE=??

all:: $(PREFIX)/lib/postgresql/postgis_geohash.so

$(PREFIX)/lib/postgresql/postgis_geohash.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure build install
