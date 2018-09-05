include ../../../adm/root.mk
include ../../package.mk

export NAME=netcdf-fortran
export VERSION=4.4.4
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=e855c789cd72e1b8bc1354366bf6ac72
DESCRIPTION=\
NETCDF_FORTRAN is the FORTRAN API of NETCDF4
WEBSITE=http://www.unidata.ucar.edu/software/netcdf/
LICENSE=MIT

all:: $(PREFIX)/lib/libnetcdff.so
$(PREFIX)/lib/libnetcdff.so:
	# for netcdf includes and libs
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/lib" EXTRACFLAGS="-I$(PREFIX)/include" download uncompress configure build install
