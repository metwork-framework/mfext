include ../../../adm/root.mk
include ../../package.mk

export NAME=the_silver_searcher
export VERSION=2.2.0
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=bad7f246c21b4cd92bd2553e45178bbf
DESCRIPTION=\
The Silver Searcher is a code searching tool similar to ack, with a focus on speed
WEBSITE=https://github.com/ggreer/the_silver_searcher
LICENSE=Apache License 2.0

all:: $(PREFIX)/bin/ag
$(PREFIX)/bin/ag:
	$(MAKE) --file=../../Makefile.standard download uncompress
	cd build/$(NAME)-$(VERSION) && ./build.sh && cp -f ag $(PREFIX)/bin
