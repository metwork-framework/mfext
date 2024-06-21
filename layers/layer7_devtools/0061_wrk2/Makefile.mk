include ../../../adm/root.mk
include ../../package.mk

export NAME=wrk2
export VERSION=master20191107
export EXTENSION=tar.bz2
export CHECKTYPE=MD5
export CHECKSUM=b3b049e7b796b10fb326f260f6076984
DESCRIPTION=\
A constant throughput, correct latency recording variant of wrk
WEBSITE=https://github.com/giltene/wrk2
LICENSE=Modified Apache 2.0 License (Version 2.0.1, February 2015)
export EXPLICIT_NAME=$(NAME)-master

export OPENSSL_HOME=$(PREFIX)/../core

all:: $(PREFIX)/bin/wrk2
$(PREFIX)/bin/wrk2:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) EXPLICIT_NAME="$(EXPLICIT_NAME)" download uncompress build
	cd build/$(EXPLICIT_NAME) && cp wrk $(PREFIX)/bin/wrk2
