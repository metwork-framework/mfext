include ../../../adm/root.mk
include ../../package.mk

export NAME=gdal
export VERSION=2.2.4
#Version 2.3.0 would need gcc >= 4.7, not standard in CentOS6
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=798c66cc8df26f204f6248358fe4fceb
DESCRIPTION=\
GDAL est un outil de traitement dimage (reprojection, sampling...) géoréférencées.\
Il incorpore également des outils de manipulations de données vectorielles (shapefiles...)\
et offre des API pour différents langages.
WEBSITE=http://www.gdal.org
LICENSE=MIT

all:: $(PREFIX)/lib/libgdal.so
$(PREFIX)/lib/libgdal.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--enable-shared --disable-static --with-pg=$(PREFIX)/../postgresql/bin/pg_config --with-openjpeg=$(PREFIX) --with-jasper=$(PREFIX) --with-hdf5=$(PREFIX) --with-netcdf --with-python=no" download uncompress configure build install
