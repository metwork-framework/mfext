include ../../../adm/root.mk
include ../../package.mk

export NAME=netcdf-c
export VERSION=4.9.3
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=c8e196f5f0b9e0d5792fce6ed6289867
DESCRIPTION=\
NETCDF-C is the C API of NETCDF format
WEBSITE=http://www.unidata.ucar.edu/software/netcdf/
LICENSE=MIT

all:: $(PREFIX)/lib/libnetcdf.so
$(PREFIX)/lib/libnetcdf.so:
	# Since we build cmake in layer core, we could build netcdf-c with cmake
	# There are no with-hdf5=DIR and with-curl=DIR options, so we keep EXTRALDFLAGS and EXTRACFLAGS
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/lib -L$(PREFIX)/../core/lib" EXTRACFLAGS="-I$(PREFIX)/include -I$(PREFIX)/../core/include" OPTIONS="--disable-static --enable-netcdf4 --enable-hdf4 --with-plugin-dir=$(PREFIX)/hdf5/lib/plugin" download uncompress configure build install
