include ../../../adm/root.mk
include ../../package.mk

export NAME=wrk
export VERSION=4.2.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=bd3ee6407b1aa8b66abfa6ee2c166849
DESCRIPTION=\
A modern HTTP benchmarking tool capable of generating significant load when run\
on a single multi-core CPU
WEBSITE=https://github.com/wg/wrk
LICENSE=Modified Apache 2.0 License (Version 2.0.1, February 2015)

all:: $(PREFIX)/bin/wrk
$(PREFIX)/bin/wrk:
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress build
	cd build/$(NAME)-$(VERSION) && cp wrk $(PREFIX)/bin
