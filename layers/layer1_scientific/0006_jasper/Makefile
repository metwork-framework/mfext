include ../../../adm/root.mk
include ../../package.mk

export NAME=jasper
export VERSION=2.0.14
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=23561b51da8eb5d0dc85b91eff3d9a7f
DESCRIPTION=\
JASPER is an official reference implementation of the JPEG-2000 Part-1 codec
WEBSITE=http://www.ece.uvic.ca/~frodo/jasper/
LICENSE=Specific (BSD type)

all:: $(PREFIX)/lib/libjasper.so
$(PREFIX)/lib/libjasper.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure_cmake build_cmake install_cmake
