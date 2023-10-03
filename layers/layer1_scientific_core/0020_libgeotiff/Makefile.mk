include ../../../adm/root.mk
include ../../package.mk

export NAME=libgeotiff
export VERSION=1.7.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=22879ac6f83460605f9c39147a2ccc7a
DESCRIPTION=\
Libgeotiff is designed to permit the extraction and parsing of the "GeoTIFF" Key directories, as well as definition and installation of GeoTIFF keys in new files
WEBSITE=https://github.com/OSGeo/libgeotiff
LICENSE=MIT

$(shell echo "prefix=$(PREFIX)" > libgeotiff.pc)
$(shell echo "exec_prefix=$(PREFIX)" >> libgeotiff.pc)
$(shell echo "libdir=$(PREFIX)/lib" >> libgeotiff.pc)
$(shell echo "includedir=$(PREFIX)/include" >> libgeotiff.pc)
$(shell echo "" >> libgeotiff.pc)
$(shell echo "Name: $(NAME)" >> libgeotiff.pc)
$(shell echo "Description: GeoTIFF file format library" >> libgeotiff.pc)
$(shell echo "Version: $(VERSION)" >> libgeotiff.pc)
$(shell cat libgeotiff.end >> libgeotiff.pc)

all:: $(PREFIX)/lib/libgeotiff.so.5
$(PREFIX)/lib/libgeotiff.so.5:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--with-zlib=yes --with-jpeg=yes --with-proj=$(PREFIX)" download uncompress configure build install
	cp libgeotiff.pc $(PREFIX)/lib/pkgconfig
	rm -f libgeotiff.pc
