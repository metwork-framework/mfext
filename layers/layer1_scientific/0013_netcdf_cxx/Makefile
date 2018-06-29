include ../../../adm/root.mk
include ../../package.mk

export NAME=netcdf-cxx4
export VERSION=4.3.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=b4a9783b2b0b98d4e6f36cc19c8d08ef
DESCRIPTION=\
NETCDF_CXX4 is the C++ API of NETCDF4
WEBSITE=http://www.unidata.ucar.edu/software/netcdf/
LICENSE=MIT

all:: $(PREFIX)/lib/libnetcdf_c++4.so
$(PREFIX)/lib/libnetcdf_c++4.so:
	#$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/lib -L$(PREFIX)/../core/lib" EXTRACFLAGS="-I$(PREFIX)/include -I$(PREFIX)/../core/include" OPTIONS="--disable-static" download uncompress configure build install
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/lib" EXTRACFLAGS="-I$(PREFIX)/include" OPTIONS="--disable-static" download uncompress configure build install
