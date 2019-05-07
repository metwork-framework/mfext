include ../../../adm/root.mk
include ../../package.mk

export NAME=libspatialite
export VERSION=4.3.0a
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=6b380b332c00da6f76f432b10a1a338c
DESCRIPTION=\
GDAL est un outil de traitement dimage (reprojection, sampling...) géoréférencées.\
Il incorpore également des outils de manipulations de données vectorielles (shapefiles...)\
et offre des API pour différents langages.
WEBSITE=https://www.gaia-gis.it/fossil/libspatialite
LICENSE=LGPL (MPL tri-license term)

all:: $(PREFIX)/lib/libspatialite.so
$(PREFIX)/lib/libspatialite.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/lib -L$(PREFIX)/../core/lib" EXTRACFLAGS="-I$(PREFIX)/include -I$(PREFIX)/../core/include" OPTIONS="--enable-shared --disable-static --enable-freexl=no" download uncompress configure build install
