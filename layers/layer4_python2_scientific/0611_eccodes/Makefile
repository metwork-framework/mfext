include ../../../adm/root.mk
include ../../package.mk

export NAME=eccodes
export VERSION=2.7.3
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=0d2603722bbbd6a7fe70b32cbb24b5ba
export EXPLICIT_NAME=$(NAME)-$(VERSION)-Source
DESCRIPTION=\
ecCodes is a package developed by ECMWF which provides an application programming interface and a set of tools for decoding and encoding messages in the following formats: \
    WMO FM-92 GRIB edition 1 and edition 2 \
    WMO FM-94 BUFR edition 3 and edition 4  \
    WMO GTS abbreviated header (only decoding).
WEBSITE=https://www.ecmwf.int/en/computing/software
LICENSE=Apache 2.0 : http://www.apache.org/licenses/LICENSE-2.0
SHORT_VERSION=2.7.3


all:: $(PREFIX)/lib/python2.7/site-packages/eccodes-$(VERSION)-py2.7.egg-info
$(PREFIX)/lib/python2.7/site-packages/eccodes-$(VERSION)-py2.7.egg-info:
	layer_wrapper --layers=python2_scientific@mfext -- $(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME="$(EXPLICIT_NAME)" EXTRALDFLAGS="-L$(PREFIX)/../scientific/lib" OPTIONS="-DBUILD_SHARED_LIBS=ON -DENABLE_NETCDF=OFF -DENABLE_FORTRAN=OFF -DENABLE_PYTHON=ON" download uncompress configure_cmake python2pyinstall_cmake
