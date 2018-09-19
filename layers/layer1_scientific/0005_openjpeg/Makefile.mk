include ../../../adm/root.mk
include ../../package.mk

export NAME=openjpeg
#Version 2.3.0 is not compatible with gdal version 2.2.2
#and gdal version 2.3.0 needs gcc >= 4.7, not standard in CentOS6
#Version 2.2.0 includes are not compatible with eccodes 2.7.3
export VERSION=2.1.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=40a7bfdcc66280b3c1402a0eb1a27624
DESCRIPTION=\
OpenJPEG is an open-source JPEG 2000 codec written in C language
WEBSITE=http://www.openjpeg.org/
LICENSE=BSD

all:: $(PREFIX)/lib/libopenjp2.so
$(PREFIX)/lib/libopenjp2.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure_cmake build_cmake install_cmake
