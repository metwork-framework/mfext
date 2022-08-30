include ../../../adm/root.mk
include ../../package.mk

export NAME=libffi
export VERSION=3.4.2
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=294b921e6cf9ab0fbaea4b639f8fdbe8
DESCRIPTION=\
A Portable Foreign Function Interface Library
WEBSITE=https://sourceware.org/libffi/
LICENSE=BSD

# Release 3.4.2 is the one available with RockyLinux 9
all:: $(PREFIX)/lib/libffi.so
$(PREFIX)/lib/libffi.so: Makefile sources Makefile.mk
	$(MAKE) --file=../../Makefile.standard OPTIONS="--libdir=$(PREFIX)/lib --enable-portable-binary --enable-shared --disable-static --disable-multi-os-directory" download uncompress configure build install
