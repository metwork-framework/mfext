include ../../../adm/root.mk
include ../../package.mk

export NAME=mapserver
export VERSION=7.2.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=03cd2532df9def0011c2f586e2e615fd
DESCRIPTION=\
MapServer is an Open Source platform for publishing spatial data and interactive mapping applications to the web.
WEBSITE=http://mapserver.org
LICENSE=MIT

all:: $(PREFIX)/bin/mapserv
$(PREFIX)/bin/mapserv:
	$(MAKE) --file=../../Makefile.standard OPTIONS="-DWITH_CURL=1 -DWITH_GIF=0 -DWITH_FCGI=0 -DWITH_HARFBUZZ=0 -DWITH_FRIBIDI=0 -DWITH_PROTOBUFC=0 -DCMAKE_PREFIX_PATH='$(PREFIX);$(PREFIX)/../scientific;$(PREFIX)/../postgresql;$(PREFIX)/../core'" download uncompress configure_cmake cmake build_cmake install_cmake
