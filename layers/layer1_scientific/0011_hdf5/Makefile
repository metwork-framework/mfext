include ../../../adm/root.mk
include ../../package.mk

export NAME=hdf5
export VERSION=1.10.2
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=41fb9347801b546fba323523a1c1af51
DESCRIPTION=\
HDF5 is a suite that makes possible the management of extremely large and complex data collections (including file format HDF5)
WEBSITE=https://www.hdfgroup.org
LICENSE=BSD

all:: $(PREFIX)/lib/libhdf5.so
$(PREFIX)/lib/libhdf5.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--enable-cxx --disable-static" download uncompress configure build install
