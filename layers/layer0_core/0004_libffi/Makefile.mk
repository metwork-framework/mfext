include ../../../adm/root.mk
include ../../package.mk

export NAME=libffi
export VERSION=3.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=41e0216cc2be4029fad3128988295f0f
DESCRIPTION=\
A Portable Foreign Function Interface Library
WEBSITE=https://sourceware.org/libffi/
LICENSE=BSD

all:: $(PREFIX)/lib/libffi.so
$(PREFIX)/lib/libffi.so: Makefile sources Makefile.mk
	$(MAKE) --file=../../Makefile.standard OPTIONS="--libdir=$(PREFIX)/lib --enable-portable-binary --enable-shared --disable-static" download uncompress configure build install
