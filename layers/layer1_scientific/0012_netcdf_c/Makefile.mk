include ../../../adm/root.mk
include ../../package.mk

export NAME=netcdf
export VERSION=4.6.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=ee81c593efc8a6229d9bcb350b6d7849
DESCRIPTION=\
NETCDF is the C API of NETCDF format
WEBSITE=http://www.unidata.ucar.edu/software/netcdf/
LICENSE=MIT

all:: $(PREFIX)/lib/libnetcdf.so
$(PREFIX)/lib/libnetcdf.so:
	# Build with cmake would need cmake >= 3.6.1, so we keep configure
	# There are no with-hdf5=DIR and with-curl=DIR options, so we keep EXTRALDFLAGS and EXTRACFLAGS
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/lib -L$(PREFIX)/../core/lib" EXTRACFLAGS="-I$(PREFIX)/include -I$(PREFIX)/../core/include" OPTIONS="--disable-static" download uncompress configure build install
