include ../../../adm/root.mk
include ../../package.mk

export NAME=hdf4
export VERSION=4.2.16-2
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=82f834cd6217ea2ae71e035268674f7e
DESCRIPTION=\
HDF4 (also known as HDF) is a library and multi-object file format for storing and managing data between machines.\
It is the first HDF format. It is considered deprecated and replaced by HDF5, but still in use.
WEBSITE=https://www.hdfgroup.org
LICENSE=BSD
export EXPLICIT_NAME=hdf-$(VERSION)

all:: $(PREFIX)/lib/libdf.so
$(PREFIX)/lib/libdf.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME=$(EXPLICIT_NAME) EXTRACFLAGS="-I$(PREFIX)/../core/include" EXTRALDFLAGS="-L$(PREFIX)/../core/lib" OPTIONS="--enable-shared --disable-static --disable-netcdf --disable-java --disable-fortran" download uncompress configure build install
