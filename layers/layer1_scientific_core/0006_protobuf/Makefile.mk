include ../../../adm/root.mk
include $(MFEXT_HOME)/share/package.mk

#In comment the changes if we decide to upgrade protobuf to 4.24.3
#3.20.3 is newer than the version available on rocky9 (3.14.0), so no hurry
#If we decide to upgrade protobuf, we will need abseil : install rpm abseil-cpp-devel rather than build abseil from sources
#But it seems that there are problems building protobuf with installed abseil...
#sources for 4.24.3 : https://github.com/protocolbuffers/protobuf/archive/refs/tags/v4.24.3.tar.gz

export NAME=protobuf
export VERSION=3.20.3
#export VERSION=4.24.3
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=399dbdc29860c1258822c8b9f5873fc9
#export CHECKSUM=1643c6153aed5b1a4ea2851fcc552568
DESCRIPTION=\
Protocol buffers are Google's language-neutral, platform-neutral, extensible \
mechanism for serializing structured data – think XML, but smaller, faster, \
and simpler.
WEBSITE=https://developers.google.com/protocol-buffers
LICENSE=Google (https://github.com/protocolbuffers/protobuf/blob/master/LICENSE)

all:: $(PREFIX)/bin/protoc
$(PREFIX)/bin/protoc:
	$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) OPTIONS="--enable-static=no" download uncompress configure build install
	#$(MAKE) --file=$(MFEXT_HOME)/share/Makefile.standard PREFIX=$(PREFIX) OPTIONS="-Dprotobuf_BUILD_TESTS=OFF -Dprotobuf_ABSL_PROVIDER=package -Dabsl_DIR=/usr/lib64/cmake/absl" download uncompress configure_cmake build_cmake install_cmake
