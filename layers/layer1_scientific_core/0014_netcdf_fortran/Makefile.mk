include ../../../adm/root.mk
include ../../package.mk

export NAME=netcdf-fortran
export VERSION=4.4.5
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=edb51c7320a9024b419b7a87e05fa79a
DESCRIPTION=\
NETCDF_FORTRAN is the FORTRAN API of NETCDF4
WEBSITE=http://www.unidata.ucar.edu/software/netcdf/
LICENSE=MIT

#We build all c/c++/fortran netcdf apis coherently with gcc/gfortran >= 4.5
#for fortran compatibily when building esmf in mfextaddon_scientific
GFORTRAN_VERSION = `gfortran --version | head -1 | cut -d" " -f4 | cut -d"." -f1-2`
DEVTOOLSET = 7

ifeq ($(shell expr $(GFORTRAN_VERSION) \< "4.5" ), 1)

all:: $(PREFIX)/lib/libnetcdff.so
$(PREFIX)/lib/libnetcdff.so:
	scl enable devtoolset-$(DEVTOOLSET) '$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/lib" EXTRACFLAGS="-I$(PREFIX)/include" download uncompress configure build install'

else

all:: $(PREFIX)/lib/libnetcdff.so
$(PREFIX)/lib/libnetcdff.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/lib" EXTRACFLAGS="-I$(PREFIX)/include" download uncompress configure build install

endif
