include ../../../adm/root.mk
include ../../package.mk

export NAME=jasper
export VERSION=4.2.5
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=b5d0ef00c9ce4120156f8b6abb065995
export SOURCE_DIR=build/$(NAME)-$(VERSION)
export BUILD_DIR=build/build-$(NAME)-$(VERSION)
DESCRIPTION=\
JASPER is a collection of software for the coding and manipulation of images. It can handle image data in a variety of formats, such as JPEG-2000
WEBSITE=https://jasper-software.github.io/jasper/
LICENSE=JasPer License Version 2.0 (https://github.com/jasper-software/jasper/blob/master/LICENSE.txt)

all:: $(PREFIX)/lib/libjasper.so
$(PREFIX)/lib/libjasper.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress
	rm -rf $(BUILD_DIR) && mkdir $(BUILD_DIR) 
	cmake -DCMAKE_INSTALL_PREFIX=$(PREFIX) -H$(SOURCE_DIR) -B$(BUILD_DIR)
	cmake --build $(BUILD_DIR)
	cmake --build $(BUILD_DIR) --target install
	mv $(PREFIX)/lib64/pkgconfig/jasper.pc $(PREFIX)/lib/pkgconfig
	mv $(PREFIX)/lib64/libjasper* $(PREFIX)/lib
	rm -rf $(PREFIX)/lib64 && cd $(PREFIX) && ln -s lib lib64
