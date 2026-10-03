include ../../../adm/root.mk
include ../../package.mk

export NAME=hdf4
export VERSION=4.4.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=2dacdbabfdefd29b4c1b0bd2cdea86b3
DESCRIPTION=\
HDF4 (also known as HDF) is a library and multi-object file format for storing and managing data between machines.\
It is the first HDF format. It is considered deprecated and replaced by HDF5, but still in use.
WEBSITE=https://www.hdfgroup.org
LICENSE=BSD
export EXPLICIT_NAME=$(NAME)-hdf$(VERSION)

all:: $(PREFIX)/lib/libhdf.so $(PREFIX)/lib/libdf.so
$(PREFIX)/lib/libhdf.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME=$(EXPLICIT_NAME) download uncompress
	mkdir build/$(NAME)-hdf$(VERSION)/build
	cd build/$(NAME)-hdf$(VERSION)/build && cmake -C ../config/cmake/cacheinit.cmake -G "Unix Makefiles" -DHDF4_ALLOW_EXTERNAL_SUPPORT:BOOL=OFF -DHDF4_USE_LIBAEC_STATIC:BOOL=OFF -DHDF4_BUILD_JAVA:BOOL=OFF -DBUILD_STATIC_LIBS:BOOL=OFF -DBUILD_TESTING:BOOL=OFF -DCMAKE_BUILD_TYPE:STRING=Release -DHDF4_BUILD_TOOLS:BOOL=ON .. && cmake --build . --config Release && cpack -C Release CPackConfig.cmake && ./HDF-$(VERSION)-Linux.sh --prefix=$(PREFIX) --include-subdir
	cd $(PREFIX) && cp -r HDF-$(VERSION)-Linux/HDF_Group/HDF/$(VERSION)/include/* include && cp -r HDF-$(VERSION)-Linux/HDF_Group/HDF/$(VERSION)/lib/* lib && cp -r HDF-$(VERSION)-Linux/HDF_Group/HDF/$(VERSION)/bin/* bin && rm -rf HDF-$(VERSION)-Linux

#for compatibility with packages using libdf.so
$(PREFIX)/lib/libdf.so:
	cd $(PREFIX)/lib && ln -s libhdf.so libdf.so
