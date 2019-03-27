include ../../../adm/root.mk
include ../../package.mk

export NAME=cdo
export VERSION=1.8.2
#Version 1.9.5 requires a compiler with support for C++11 language
#(gcc-c++ >= 4.8.1 not available on CentOS6)
# Pas reussi a compiler la partie python dans cette version 1.8.2...
export EXTENSION=tar.gz
export CHECKTYPE=MD5
#export CHECKSUM=0c60f2c94dc5c76421ecf363153a5043 (1.9.5)
export CHECKSUM=6a2e2f99b7c67ee9a512c40a8d4a7121
DESCRIPTION=\
CDO is a collection of command line Operators to manipulate and analyse Climate and NWP model Data.\
Supported data formats are GRIB 1/2, netCDF 3/4, SERVICE, EXTRA and IEG. There are more than 600 \
operators available.
WEBSITE=https://code.mpimet.mpg.de/projects/cdo/
LICENSE=GNU General Public License

all:: $(PREFIX)/bin/cdo
$(PREFIX)/bin/cdo:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/../scientific_core/lib" EXTRACFLAGS="-I$(PREFIX)/../scientific_core/include" OPTIONS="--with-netcdf=$(PREFIX) --with-hdf5=$(PREFIX) --with-proj=$(PREFIX) --with-curl=$(PREFIX)/../core --with-libxml2=$(PREFIX)/../core  --enable-cdi-lib  --enable-static=no" download uncompress configure build install
