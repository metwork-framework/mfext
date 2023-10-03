include ../../../adm/root.mk
include ../../package.mk

export NAME=geos
export VERSION=3.12.0
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=b2538c3b0b719c64797256ceef5fcc78
DESCRIPTION=\
GEOS is a C++ port of the ​JTS Topology Suite (JTS). \
GEOS provides spatial functionality. Especially, it allows to calculate complex intersections of polygons.
WEBSITE=http://trac.osgeo.org/geos/
LICENSE=LGPL

all:: $(PREFIX)/lib/libgeos.so
$(PREFIX)/lib/libgeos.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure_cmake build_cmake install_cmake
