include ../../../adm/root.mk
include ../../package.mk

export NAME=hdf5
export VERSION=1.14.6
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=73b513b9c40a8ca2913fcb38570ecdbd
export EXPLICIT_NAME=$(NAME)-$(NAME)_$(VERSION)
DESCRIPTION=\
HDF5 is a suite that makes possible the management of extremely large and complex data collections (including file format HDF5)
WEBSITE=https://www.hdfgroup.org
LICENSE=BSD

#We do not build with MPI support (too complicated with h5py on python3_scientific side and with other packages linking with hdf5)

all:: $(PREFIX)/lib/libhdf5.so
$(PREFIX)/lib/libhdf5.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME="$(EXPLICIT_NAME)" OPTIONS="--enable-cxx --enable-fortran --disable-static --with-szlib --with-default-plugindir=$(PREFIX)/hdf5/lib/plugin" download uncompress configure build install
