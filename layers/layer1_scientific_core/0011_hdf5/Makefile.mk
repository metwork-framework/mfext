include ../../../adm/root.mk
include ../../package.mk

export NAME=hdf5
export VERSION=1.14.3
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=90d2568cb0250d70559999da0cbe6cb9
DESCRIPTION=\
HDF5 is a suite that makes possible the management of extremely large and complex data collections (including file format HDF5)
WEBSITE=https://www.hdfgroup.org
LICENSE=BSD

all:: $(PREFIX)/lib/libhdf5.so
$(PREFIX)/lib/libhdf5.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--enable-cxx --enable-fortran --disable-static --with-szlib --with-default-plugindir=$(PREFIX)/hdf5/lib/plugin" download uncompress configure build install
