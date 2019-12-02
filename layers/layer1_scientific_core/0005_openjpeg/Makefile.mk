include ../../../adm/root.mk
include ../../package.mk

export NAME=openjpeg
export VERSION=2.3.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=3b9941dc7a52f0376694adb15a72903f
DESCRIPTION=\
OpenJPEG is an open-source JPEG 2000 codec written in C language
WEBSITE=http://www.openjpeg.org/
LICENSE=BSD

all:: $(PREFIX)/lib/libopenjp2.so
$(PREFIX)/lib/libopenjp2.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure_cmake build_cmake install_cmake
	#The link below waiting for eccodes to build with openjpeg > 2.1
	ln -s $(PREFIX)/include/openjpeg-2.3 $(PREFIX)/include/openjpeg-2.1
