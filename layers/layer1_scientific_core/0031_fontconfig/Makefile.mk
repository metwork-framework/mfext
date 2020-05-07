include ../../../adm/root.mk
include ../../package.mk

export NAME=fontconfig
export VERSION=2.13.92
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=d5431bf5456522380d4c2c9c904a6d96
DESCRIPTION=\
Fontconfig is a library for configuring and customizing font access
WEBSITE=https://www.freedesktop.org/wiki/Software/fontconfig/
LICENSE=MIT

all::$(PREFIX)/lib/libfontconfig.so
$(PREFIX)/lib/libfontconfig.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress configure build install

