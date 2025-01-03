include ../../../adm/root.mk
include ../../package.mk

export NAME=hdf4
export VERSION=4.3.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=9789b5ad3341ce5f25fac1de231e2608
DESCRIPTION=\
HDF4 (also known as HDF) is a library and multi-object file format for storing and managing data between machines.\
It is the first HDF format. It is considered deprecated and replaced by HDF5, but still in use.
WEBSITE=https://www.hdfgroup.org
LICENSE=BSD
export EXPLICIT_NAME=$(NAME)-hdf$(VERSION)

all:: $(PREFIX)/lib/libdf.so $(PREFIX)/include/hdfi.h
$(PREFIX)/lib/libdf.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME=$(EXPLICIT_NAME) EXTRACFLAGS="-I$(PREFIX)/../core/include" EXTRALDFLAGS="-L$(PREFIX)/../core/lib" OPTIONS="--enable-shared --disable-static --disable-netcdf --disable-java --disable-fortran --with-szlib" download uncompress configure build install
#add hdfi.h for compatibility (pyhdf <= 0.11.4 is using hdfi.h, next release will not do so)
$(PREFIX)/include/hdfi.h:
	cd $(PREFIX)/include && ln -s hdf.h hdfi.h
