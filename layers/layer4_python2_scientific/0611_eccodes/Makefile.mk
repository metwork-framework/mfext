include ../../../adm/root.mk
include ../../package.mk

export NAME=eccodes
export VERSION=2.9.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=fab239b47a0a8a1531b68e1e76374321
export EXPLICIT_NAME=$(NAME)-$(VERSION)-Source
DESCRIPTION=\
ecCodes is a package developed by ECMWF which provides an application programming interface and a set of tools for decoding and encoding messages in the following formats: \
    WMO FM-92 GRIB edition 1 and edition 2 \
    WMO FM-94 BUFR edition 3 and edition 4  \
    WMO GTS abbreviated header (only decoding).
WEBSITE=https://www.ecmwf.int/en/computing/software
LICENSE=Apache 2.0 : http://www.apache.org/licenses/LICENSE-2.0


all:: $(PREFIX)/lib/python2.7/site-packages/eccodes-$(VERSION)-py2.7.egg-info
$(PREFIX)/lib/python2.7/site-packages/eccodes-$(VERSION)-py2.7.egg-info:
	mkdir -p build/$(NAME)-$(VERSION)-Source/build/lib
	rm -f build/$(NAME)-$(VERSION)-Source/build/lib/libeccodes.so
	ln -s $(PREFIX)/../scientific/lib/libeccodes.so build/$(NAME)-$(VERSION)-Source/build/lib/libeccodes.so
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME="$(EXPLICIT_NAME)" OPTIONS="-DBUILD_SHARED_LIBS=ON -DENABLE_FORTRAN=OFF -DENABLE_NETCDF=OFF -DENABLE_PYTHON=ON -DENABLE_JPG=ON -DOPENJPEG_PATH=$(PREFIX)/../scientific" download uncompress configure_cmake python2pyinstall_cmake
	rm -f build/$(NAME)-$(VERSION)-Source/build/lib/libeccodes.so
