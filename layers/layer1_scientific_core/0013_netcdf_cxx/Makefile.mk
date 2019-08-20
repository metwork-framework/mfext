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

#We build all c/c++/fortran netcdf apis coherently with gcc/gfortran >= 4.5
#for fortran compatibily when building esmf in mfextaddon_scientific
GFORTRAN_VERSION = `gfortran --version | head -1 | cut -d" " -f4 | cut -d"." -f1-2`
DEVTOOLSET = 7

ifeq ($(shell expr $(GFORTRAN_VERSION) \< "4.5" ), 1)

all:: $(PREFIX)/lib/libnetcdf_c++4.so
$(PREFIX)/lib/libnetcdf_c++4.so:
	# configure doesn't use LD_LIBRARY_PATH nor PKG_CONFIG_PATH, so we need to keep EXTRALDFLAGS and EXTRACFLAGS
	# for netcdf includes and libs
	scl enable devtoolset-$(DEVTOOLSET) '$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/lib" EXTRACFLAGS="-I$(PREFIX)/include" OPTIONS="--disable-static" download uncompress configure build install'

else

all:: $(PREFIX)/lib/libnetcdf_c++4.so
$(PREFIX)/lib/libnetcdf_c++4.so:
	# configure doesn't use LD_LIBRARY_PATH nor PKG_CONFIG_PATH, so we need to keep EXTRALDFLAGS and EXTRACFLAGS
	# for netcdf includes and libs
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/lib" EXTRACFLAGS="-I$(PREFIX)/include" OPTIONS="--disable-static" download uncompress configure build install

endif
