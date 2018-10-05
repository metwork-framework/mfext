include ../../../adm/root.mk
include ../../package.mk

export NAME=Magics
export VERSION=3.0.4
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=52d72056ce074fdeb4127217b601ed8f
export EXPLICIT_NAME=$(NAME)-$(VERSION)-Source
export SCIENTIFIC_ROOT=$(PREFIX)/../scientific

DESCRIPTION=\
Magics is the latest generation of the ECMWF's meteorological plotting software. \
It can be accessed directly through its Python interface. \
Magics-3.0 is the first version offering a Python 3 Interface.
WEBSITE=https://www.ecmwf.int/en/computing/software
LICENSE=Apache 2.0 : http://www.apache.org/licenses/LICENSE-2.0

all:: $(PREFIX)/bin/magmlx
$(PREFIX)/bin/magmlx:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME="$(EXPLICIT_NAME)" EXTRACFLAGS="-I$(PREFIX)/include" EXTRALDFLAGS="-L$(PREFIX)/lib" OPTIONS="-DENABLE_PYTHON=ON -DENABLE_FORTRAN=OFF -DBOOST_ROOT=$(SCIENTIFIC_ROOT) -DNETCDF_PATH=$(SCIENTIFIC_ROOT) -DPROJ4_PATH=$(SCIENTIFIC_ROOT)" download uncompress configure_cmake build_cmake install_cmake
