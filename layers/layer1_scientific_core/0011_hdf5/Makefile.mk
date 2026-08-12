include ../../../adm/root.mk
include ../../package.mk

export NAME=hdf5
export VERSION=2.1.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=3df68e8461d0c254802c6f3763646ca9
export EXPLICIT_NAME=$(NAME)-$(VERSION)
DESCRIPTION=\
HDF5 is a suite that makes possible the management of extremely large and complex data collections (including file format HDF5)
WEBSITE=https://www.hdfgroup.org
LICENSE=BSD

#We do not build with MPI support (too complicated with h5py on python3_scientific side and with other packages linking with hdf5)

all:: $(PREFIX)/lib/libhdf5.so
$(PREFIX)/lib/libhdf5.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME="$(EXPLICIT_NAME)" OPTIONS="-DHDF5_BUILD_CPP_LIB=ON -DHDF5_BUILD_FORTRAN=ON -DBUILD_STATIC_LIBS=OFF -DHDF5_ENABLE_ZLIB_SUPPORT=ON -DHDF5_ENABLE_SZIP_SUPPORT=ON -DH5_DEFAULT_PLUGINDIR=$(PREFIX)/hdf5/lib/plugin" download uncompress configure_cmake build_cmake install_cmake
