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

# proj > 5.2.0 needs C++11 to build (not natively available on CentOS6).
# So we build it with temporary scl if gcc < 4.8
GCC_VERSION = `gcc --version | head -1 | cut -d" " -f3 | cut -d"." -f1-2`
DEVTOOLSET = 7

ifeq ($(shell expr $(GCC_VERSION) \< "4.8" ), 1)

all:: $(PREFIX)/lib/libproj.so
$(PREFIX)/lib/libproj.so:
	scl enable devtoolset-$(DEVTOOLSET) '$(MAKE) --file=../../Makefile.standard OPTIONS="--without-jni" PREFIX=$(PREFIX) download uncompress configure build install'
	echo "<900913> +proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900914> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900915> +proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs  <>" >>$(PREFIX)/share/proj/epsg
	#echo "<900916> +proj=skmerc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +gamma=-45.0 +units=m +nadgrids=@null +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900917> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-155.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900918> +proj=stere +a=6378160 +b=6356000 +lat_0=-90 +lat_ts=-45 +lon_0=-141.7 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900919> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-103.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900920> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-45.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900921> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-20.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900922> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=11.1 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900923> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=65.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900924> +proj=stere +a=6378160 +b=6356000 +lat_0=-90 +lat_ts=-45 +lon_0=96.7 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900925> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-65.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900926> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-50.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900927> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-35.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900928> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-30.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900929> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-25.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900930> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=5.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg

else

all:: $(PREFIX)/lib/libproj.so
$(PREFIX)/lib/libproj.so:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--without-jni" PREFIX=$(PREFIX) download uncompress configure build install
	echo "<900913> +proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900914> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900915> +proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs  <>" >>$(PREFIX)/share/proj/epsg
	#echo "<900916> +proj=skmerc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +gamma=-45.0 +units=m +nadgrids=@null +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900917> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-155.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900918> +proj=stere +a=6378160 +b=6356000 +lat_0=-90 +lat_ts=-45 +lon_0=-141.7 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900919> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-103.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900920> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-45.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900921> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-20.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900922> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=11.1 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900923> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=65.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900924> +proj=stere +a=6378160 +b=6356000 +lat_0=-90 +lat_ts=-45 +lon_0=96.7 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900925> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-65.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900926> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-50.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900927> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-35.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900928> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-30.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900929> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=-25.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900930> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=5.0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg

endif
