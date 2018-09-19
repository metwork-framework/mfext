include ../../../adm/root.mk
include ../../package.mk

export NAME=yajl
export VERSION=2.1.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=6887e0ed7479d2549761a4d284d3ecb0
DESCRIPTION=\
Yet Another JSON Library (YAJL) is a small event-driven (SAX-style) JSON parser written in ANSI C, and a small validating JSON generator
WEBSITE=https://lloyd.github.io/yajl/
LICENSE=BSD

all::$(PREFIX)/lib/libyajl.so
$(PREFIX)/lib/libyajl.so:
	$(MAKE) --file=../../Makefile.standard download uncompress configure_cmake build_cmake install_cmake
