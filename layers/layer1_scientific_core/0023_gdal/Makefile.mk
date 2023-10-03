include ../../../adm/root.mk
include ../../package.mk

export NAME=gdal
export VERSION=3.7.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=d6ffb51d21a619d0f242957a6078ffb3
DESCRIPTION=\
GDAL is a set of libraries and tools for raster and vector geospatial data formats. \
As a library, it presents a single raster abstract data model and single vector abstract data model \
to the calling application for all supported formats. It also comes with a variety of useful command line utilities \
and APIs for data translation and processing.
WEBSITE=http://www.gdal.org
LICENSE=MIT

all:: $(PREFIX)/lib/libgdal.so
$(PREFIX)/lib/libgdal.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="-DGDAL_USE_INTERNAL_LIBS=WHEN_NO_EXTERNAL -DCMAKE_BUILD_TYPE=Release" download uncompress configure_cmake build_cmake install_cmake

