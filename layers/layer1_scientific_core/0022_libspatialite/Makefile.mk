include ../../../adm/root.mk
include ../../package.mk

export NAME=libspatialite
export VERSION=5.1.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=2db597114bd6ee20db93de3984fd116c
DESCRIPTION=\
SPATIALITE is an open source library intended to extend the SQLite core to \
support fully fledged Spatial SQL capabilities. Using SQLite + SpatiaLite you \
can effectively deploy an alternative open source Spatial DBMS roughly \
equivalent to PostgreSQL + PostGIS
WEBSITE=https://www.gaia-gis.it/fossil/libspatialite
LICENSE=LGPL (MPL tri-license term)

all:: $(PREFIX)/lib/libspatialite.so
$(PREFIX)/lib/libspatialite.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/lib -L$(PREFIX)/../core/lib" EXTRACFLAGS="-I$(PREFIX)/include -I$(PREFIX)/../core/include" OPTIONS="--enable-shared --disable-static --enable-freexl=no --enable-rttopo=no --enable-minizip=no" download uncompress configure build install
