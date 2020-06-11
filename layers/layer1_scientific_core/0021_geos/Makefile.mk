include ../../../adm/root.mk
include ../../package.mk

export NAME=geos
export VERSION=3.8.0
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=6fe3ad412a1162b2ed7c7ed52ed974c0
DESCRIPTION=\
GEOS is a C++ port of the ​JTS Topology Suite (JTS). \
GEOS provides spatial functionality. Especially, it allows to calculate complex intersections of polygons.
WEBSITE=http://trac.osgeo.org/geos/
LICENSE=LGPL

all:: $(PREFIX)/lib/libgeos.so
$(PREFIX)/lib/libgeos.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX)  OPTIONS="--disable-static" download uncompress configure build install
