include ../../../adm/root.mk
include ../../package.mk

export NAME=gdal
export VERSION=3.0.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=8a31507806b26f070858558aaad42277
DESCRIPTION=\
GDAL is a set of libraries and tools for raster and vector geospatial data formats. \
As a library, it presents a single raster abstract data model and single vector abstract data model \
to the calling application for all supported formats. It also comes with a variety of useful command line utilities \
and APIs for data translation and processing.
WEBSITE=http://www.gdal.org
LICENSE=MIT

all:: $(PREFIX)/lib/libgdal.so
$(PREFIX)/lib/libgdal.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--enable-shared --disable-static --with-pg=yes --with-png=$(PREFIX)/../core --with-proj=$(PREFIX) --with-openjpeg=$(PREFIX) --with-jasper=$(PREFIX) --with-hdf5=$(PREFIX) --with-curl=$(PREFIX)/../core/bin/curl-config --with-sqlite3=$(PREFIX)/../core --with-libjson-c=$(PREFIX)/../core --with-spatialite=$(PREFIX) --with-netcdf --with-python=no" download uncompress configure build install

