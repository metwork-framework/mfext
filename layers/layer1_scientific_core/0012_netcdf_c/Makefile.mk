include ../../../adm/root.mk
include ../../package.mk

export NAME=netcdf-c
export VERSION=4.7.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=abdb55e6df783b5a4c7645b230ab0b98
DESCRIPTION=\
NETCDF-C is the C API of NETCDF format
WEBSITE=http://www.unidata.ucar.edu/software/netcdf/
LICENSE=MIT

#We build all c/c++/fortran netcdf apis coherently with gcc/gfortran >= 4.5
#for fortran compatibily when building esmf in mfextaddon_scientific
GFORTRAN_VERSION = `gfortran --version | head -1 | cut -d" " -f4 | cut -d"." -f1-2`
DEVTOOLSET = 7

ifeq ($(shell expr $(GFORTRAN_VERSION) \< "4.5" ), 1)

all:: $(PREFIX)/lib/libnetcdf.so
$(PREFIX)/lib/libnetcdf.so:
	# Build with cmake would need cmake >= 3.6.1, so we keep configure
	# There are no with-hdf5=DIR and with-curl=DIR options, so we keep EXTRALDFLAGS and EXTRACFLAGS
	scl enable devtoolset-$(DEVTOOLSET) '$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/lib -L$(PREFIX)/../core/lib" EXTRACFLAGS="-I$(PREFIX)/include -I$(PREFIX)/../core/include" OPTIONS="--disable-static" download uncompress configure build install'

else

all:: $(PREFIX)/lib/libnetcdf.so
$(PREFIX)/lib/libnetcdf.so:
	# Build with cmake would need cmake >= 3.6.1, so we keep configure
	# There are no with-hdf5=DIR and with-curl=DIR options, so we keep EXTRALDFLAGS and EXTRACFLAGS
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/lib -L$(PREFIX)/../core/lib" EXTRACFLAGS="-I$(PREFIX)/include -I$(PREFIX)/../core/include" OPTIONS="--disable-static" download uncompress configure build install

endif
