include ../../../adm/root.mk
include ../../package.mk

export NAME=xz
export VERSION=5.2.5
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=33ab3ef79aa1146b83b778210e7b0a54
DESCRIPTION=\
XZ Utils is free general-purpose data compression software with a high compression ratio. XZ Utils are the successor to LZMA Utils.
WEBSITE=https://tukaani.org/xz/
LICENSE=Public domain (liblzma) + GNU LGPLv2.1 + GPLv2 + GPLv3

all:: $(PREFIX)/lib/liblzma.so
$(PREFIX)/lib/liblzma.so: Makefile sources Makefile.mk
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) OPTIONS="--enable-shared --disable-static" download uncompress configure build install
