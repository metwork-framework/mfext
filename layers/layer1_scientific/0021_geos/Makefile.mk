include ../../../adm/root.mk
include ../../package.mk

export NAME=geos
export VERSION=3.7.1
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=62149456d21dabee44999f644c986ab0
DESCRIPTION=\
GEOS est un port de JTS (Java Topology Suite) en C++\
Il permet notamment de calculer des intersections complexes de polygones
WEBSITE=http://trac.osgeo.org/geos/
LICENSE=LGPL

# geos 3.7.1 needs C++11 to build (not natively available on CentOS6).
# So we build it with temporary scl if gcc < 4.8
GCC_VERSION = `gcc --version | head -1 | cut -d" " -f3 | cut -d"." -f1-2`
DEVTOOLSET = 7

ifeq ($(shell expr $(GCC_VERSION) \< "4.8" ), 1)

all:: $(PREFIX)/lib/libgeos.so
$(PREFIX)/lib/libgeos.so:
	scl enable devtoolset-$(DEVTOOLSET) '$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure build install'

else

all:: $(PREFIX)/lib/libgeos.so
$(PREFIX)/lib/libgeos.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure build install

endif
