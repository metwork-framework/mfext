include ../../../adm/root.mk
include ../../package.mk

export NAME=netcdf-fortran
export VERSION=4.6.4
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=0c7a05fee9c5f104912fb4c68a0c2192
DESCRIPTION=\
NETCDF_FORTRAN is the FORTRAN API of NETCDF4
WEBSITE=http://www.unidata.ucar.edu/software/netcdf/
LICENSE=MIT

export HDF5_PLUGIN_PATH=$(PREFIX)/../scientific_core/hdf5/lib/plugin

all:: $(PREFIX)/lib/libnetcdff.so
$(PREFIX)/lib/libnetcdff.so:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) OPTIONS="--enable-zstandard_plugin=yes --enable-static=no" EXTRALDFLAGS="-L$(PREFIX)/lib" EXTRACFLAGS="-I$(PREFIX)/include" download uncompress configure build install
