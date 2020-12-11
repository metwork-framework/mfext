include ../../../adm/root.mk
include ../../package.mk

export NAME=cmake
export VERSION=3.19.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=f2969ca3cf90a647c6c9f55b949f6cc1
DESCRIPTION=\
CMAKE is an open-source, cross-platform family of tools designed to build, test and package software
WEBSITE=https://cmake.org/
LICENSE=BSD3

all::$(PREFIX)/bin/cmake
$(PREFIX)/bin/cmake:
	$(MAKE) --file=../../Makefile.standard OPTIONS="--system-curl --system-liblzma" download uncompress configure build install
	cd $(PREFIX)/bin && ln -s cmake cmake3 && ln -s ccmake ccmake3 && ln -s cpack cpack3 && ln -s ctest ctest3
