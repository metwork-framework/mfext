include ../../../adm/root.mk
include ../../package.mk

export NAME=boost
export VERSION=1_67_0
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=ced776cb19428ab8488774e1415535ab
export EXPLICIT_NAME=$(NAME)_$(VERSION)
DESCRIPTION=\
BOOST is a free peer-reviewed portable C++ source libraries
WEBSITE=https://www.boost.org/
LICENSE=BSD type

all:: $(PREFIX)/lib/libboost_regex.so
$(PREFIX)/lib/libboost_regex.so:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME="$(EXPLICIT_NAME)" download uncompress
	cd build/$(EXPLICIT_NAME) && ./bootstrap.sh --prefix=$(PREFIX) --without-libraries=python && ./b2 install
