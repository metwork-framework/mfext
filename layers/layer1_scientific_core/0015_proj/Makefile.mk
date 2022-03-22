include ../../../adm/root.mk
include ../../package.mk

#TODO : port SkewMercator patch (proj4-skewmercator.patch with PJ_skmerc.c)
#from 4.8 to 5.2 or 6.1 (projections/skmerc.cpp)
#TODO : build 6.1.0 when https://github.com/SciTools/cartopy/issues/1288
#will be released in cartopy

export NAME=proj
export VERSION=6.2.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=9f874e227d221daf95f7858dc55dfa3e
DESCRIPTION=\
PROJ4 is a generic coordinate transformation software that transforms geospatial coordinates \
from one coordinate reference system (CRS) to another.
WEBSITE=http://trac.osgeo.org/proj/
LICENSE=MIT

all:: $(PREFIX)/lib/libproj.so
$(PREFIX)/lib/libproj.so:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--without-jni" PREFIX=$(PREFIX) download uncompress configure build install
