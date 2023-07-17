include ../../../adm/root.mk
include ../../package.mk

export NAME=protobuf-c
export VERSION=1.4.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=8414a07bd5c7147f01527090c78e1b4b
DESCRIPTION=\
PROTOBUF-C is a C implementation of the Google Protocol Buffers data serialization format
WEBSITE=https://github.com/protobuf-c
LICENSE=Copyright (c) 2008-2022, Dave Benson and the protobuf-c authors

all:: $(PREFIX)/bin/protoc-c

$(PREFIX)/bin/protoc-c:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress autoreconf configure build install
