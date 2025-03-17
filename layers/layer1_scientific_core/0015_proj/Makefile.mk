include ../../../adm/root.mk
include ../../package.mk

export NAME=proj
export VERSION=9.6.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=f6275f374409cb22efe25c5bc4e29459
DESCRIPTION=\
PROJ4 is a generic coordinate transformation software that transforms geospatial coordinates \
from one coordinate reference system (CRS) to another.
WEBSITE=http://trac.osgeo.org/proj/
LICENSE=MIT

all:: $(PREFIX)/lib/libproj.so
$(PREFIX)/lib/libproj.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="-DBUILD_TESTING=OFF -DCMAKE_PREFIX_PATH='$(PREFIX);$(PREFIX)/../core'" download uncompress configure_cmake build_cmake install_cmake
