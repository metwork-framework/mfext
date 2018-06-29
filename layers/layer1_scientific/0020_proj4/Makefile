include ../../../adm/root.mk
include ../../package.mk

export NAME=proj
export VERSION=4.8.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=d815838c92a29179298c126effbb1537
DESCRIPTION=\
PROJ4 est une bibliotheque C pour le calcul des projections\
(au sens mathematique du terme)
WEBSITE=http://trac.osgeo.org/proj/
LICENSE=MIT

all:: $(PREFIX)/lib/libproj.so
$(PREFIX)/lib/libproj.so:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--without-jni" PREFIX=$(PREFIX) download uncompress configure build install
	echo "<900913> +proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900914> +proj=stere +a=6378160 +b=6356000 +lat_0=90 +lat_ts=45 +lon_0=0 +units=m +no_defs" >>$(PREFIX)/share/proj/epsg
	echo "<900915> +proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs  <>" >>$(PREFIX)/share/proj/epsg
	echo "<900916> +proj=skmerc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +gamma=-45.0 +units=m +nadgrids=@null +no_defs" >>$(PREFIX)/share/proj/epsg
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
