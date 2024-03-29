include ../../../adm/root.mk
include ../../package.mk

#TODO : port SkewMercator patch (proj4-skewmercator.patch with PJ_skmerc.c)
#from 4.8 to 5.2 or 6.1 (projections/skmerc.cpp)

export NAME=proj
export VERSION=9.3.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=f1d70cb8873bb4429a03c437c65c41c4
DESCRIPTION=\
PROJ4 is a generic coordinate transformation software that transforms geospatial coordinates \
from one coordinate reference system (CRS) to another.
WEBSITE=http://trac.osgeo.org/proj/
LICENSE=MIT

all:: $(PREFIX)/lib/libproj.so
$(PREFIX)/lib/libproj.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="-DBUILD_TESTING=OFF -DCMAKE_PREFIX_PATH='$(PREFIX);$(PREFIX)/../core'" download uncompress configure_cmake build_cmake install_cmake
