include ../../../adm/root.mk
include ../../package.mk

export NAME=netcdf-cxx4
export VERSION=4.3.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=19cccc27a24fc9095ddbe84bf90ebc83
DESCRIPTION=\
NETCDF_CXX4 is the C++ API of NETCDF4
WEBSITE=http://www.unidata.ucar.edu/software/netcdf/
LICENSE=MIT

all:: $(PREFIX)/lib/libnetcdf_c++4.so
$(PREFIX)/lib/libnetcdf_c++4.so:
	# configure doesn't use LD_LIBRARY_PATH nor PKG_CONFIG_PATH, so we
	# need to keep EXTRALDFLAGS and EXTRACFLAGS
	# for netcdf includes and libs
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/lib" EXTRACFLAGS="-I$(PREFIX)/include" OPTIONS="--disable-static" download uncompress configure build install
