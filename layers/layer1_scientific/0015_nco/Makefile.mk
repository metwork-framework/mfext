include ../../../adm/root.mk
include ../../package.mk

export NAME=nco
export VERSION=4.7.6
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=84296a0ec44b9a58dab198fda9fac7f0
DESCRIPTION=\
The netCDF Operators, NCO, are a suite of programs known as operators. \
The operators facilitate manipulation and analysis of self-describing\
data stored in the freely available netCDF and HDF formats
WEBSITE=http://nco.sourceforge.net
LICENSE=GNU General Public License

all:: $(PREFIX)/lib/libnco.so
$(PREFIX)/lib/libnco.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXTRALDFLAGS="-L$(PREFIX)/lib" EXTRACFLAGS="-I$(PREFIX)/include" OPTIONS="--enable-static=no" download uncompress configure build install
