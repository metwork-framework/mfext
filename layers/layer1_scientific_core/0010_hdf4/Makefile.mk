include ../../../adm/root.mk
include ../../package.mk

export NAME=hdf4
export VERSION=4.2.15
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=27ab87b22c31906883a0bfaebced97cb
DESCRIPTION=\
HDF4 (also known as HDF) is a library and multi-object file format for storing and managing data between machines.\
It is the first HDF format. It is considered deprecated and replaced by HDF5, but still in use.
WEBSITE=https://www.hdfgroup.org
LICENSE=BSD
export EXPLICIT_NAME=hdf-$(VERSION)

all:: $(PREFIX)/lib/libdf.so
$(PREFIX)/lib/libdf.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME=$(EXPLICIT_NAME) OPTIONS="--enable-shared --disable-static --disable-netcdf --disable-java --disable-fortran" download uncompress configure build install
