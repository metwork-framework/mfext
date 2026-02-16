include ../../../adm/root.mk
include ../../package.mk

export NAME=libaec
export VERSION=1.1.5
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=5990132814acf4cc302df1b2668c62dd
DESCRIPTION=\
LIBAEC provides fast lossless compression of 1 up to 32 bit wide signed or unsigned integers (samples). The library achieves best results for low entropy data.
WEBSITE=https://github.com/MathisRosenhauer/libaec
LICENSE=https://github.com/MathisRosenhauer/libaec/blob/master/LICENSE.txt

all:: $(PREFIX)/lib/libaec.so.0.1.5
$(PREFIX)/lib/libaec.so.0.1.5:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="-DBUILD_STATIC_LIBS=OFF" download uncompress configure_cmake build_cmake install_cmake
