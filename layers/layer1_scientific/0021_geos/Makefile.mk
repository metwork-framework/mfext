include ../../../adm/root.mk
include ../../package.mk

export NAME=geos
export VERSION=3.6.2
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=a32142343c93d3bf151f73db3baa651f
DESCRIPTION=\
GEOS est un port de JTS (Java Topology Suite) en C++\
Il permet notamment de calculer des intersections complexes de polygones
WEBSITE=http://trac.osgeo.org/geos/
LICENSE=LGPL

all:: $(PREFIX)/lib/libgeos.so
$(PREFIX)/lib/libgeos.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure build install
