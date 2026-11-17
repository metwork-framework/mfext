include ../../../adm/root.mk
include ../../package.mk

export NAME=geos
export VERSION=3.15.0
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=b6c9254c4b45e226c9e2d751acce5079
DESCRIPTION=\
GEOS is a C++ port of the ​JTS Topology Suite (JTS). \
GEOS provides spatial functionality. Especially, it allows to calculate complex intersections of polygons.
WEBSITE=http://trac.osgeo.org/geos/
LICENSE=LGPL

all:: $(PREFIX)/lib/libgeos.so
$(PREFIX)/lib/libgeos.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure_cmake build_cmake install_cmake
