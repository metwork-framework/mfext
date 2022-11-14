include ../../../adm/root.mk
include ../../package.mk

export NAME=hdf5
export VERSION=1.12.2
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=4f4c87981ee5e3db12975f0904b634e2
DESCRIPTION=\
HDF5 is a suite that makes possible the management of extremely large and complex data collections (including file format HDF5)
WEBSITE=https://www.hdfgroup.org
LICENSE=BSD

# Version 1.13 is experimental (10/11/2022) and gdal 3.5.3 or 3.6.0 doesn't build against release 1.13.2 or 1.13.3 (it will be ok in release 3.6.1)
# See https://github.com/OSGeo/gdal/issues/6657
# force build
all:: $(PREFIX)/lib/libhdf5.so
$(PREFIX)/lib/libhdf5.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--enable-cxx --disable-static --with-szlib" download uncompress configure build install
