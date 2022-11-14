include ../../../adm/root.mk
include ../../package.mk

export NAME=gdal
export VERSION=3.5.3
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=d1defb6200dc419c4bfcaf1d8ebd0d4a
DESCRIPTION=\
GDAL is a set of libraries and tools for raster and vector geospatial data formats. \
As a library, it presents a single raster abstract data model and single vector abstract data model \
to the calling application for all supported formats. It also comes with a variety of useful command line utilities \
and APIs for data translation and processing.
WEBSITE=http://www.gdal.org
LICENSE=MIT

all:: $(PREFIX)/lib/libgdal.so
$(PREFIX)/lib/libgdal.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--enable-shared --disable-static --with-pg=yes --with-liblzma=yes --with-proj=$(PREFIX) --with-openjpeg --with-hdf5=$(PREFIX) --with-hdf4=$(PREFIX) --with-spatialite=$(PREFIX) --with-libtiff=yes --with-geotiff=$(PREFIX) --with-netcdf --with-python=no" download uncompress configure build install

