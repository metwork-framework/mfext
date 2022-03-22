include ../../../adm/root.mk
include ../../package.mk

export NAME=libgeotiff
export VERSION=1.7.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=22879ac6f83460605f9c39147a2ccc7a
DESCRIPTION=\
Libgeotiff is designed to permit the extraction and parsing of the "GeoTIFF" Key directories, as well as definition and installation of GeoTIFF keys in new files
WEBSITE=https://www.hdfgroup.org
LICENSE=BSD

all:: $(PREFIX)/lib/libgeotiff.so.5
$(PREFIX)/lib/libgeotiff.so.5:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--with-zlib=yes --with-jpeg=yes --with-proj=$(PREFIX)" download uncompress configure build install
