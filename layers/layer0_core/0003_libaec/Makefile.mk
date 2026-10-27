include ../../../adm/root.mk
include ../../package.mk

export NAME=libaec
export VERSION=1.1.7
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=14dc76315b49b949c8882ead3a984fc9
DESCRIPTION=\
LIBAEC provides fast lossless compression of 1 up to 32 bit wide signed or unsigned integers (samples). The library achieves best results for low entropy data.
WEBSITE=https://github.com/MathisRosenhauer/libaec
LICENSE=https://github.com/MathisRosenhauer/libaec/blob/master/LICENSE.txt

all:: $(PREFIX)/lib/libaec.so.0
$(PREFIX)/lib/libaec.so.0:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="-DBUILD_STATIC_LIBS=OFF" download uncompress configure_cmake build_cmake install_cmake
