include ../../../adm/root.mk
include ../../package.mk

export NAME=log_proxy
export VERSION=0.0.3
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=24b47c476ee3a71a5b37aba1d2755d3f
DESCRIPTION=\
log_proxy is a tiny C utility for log rotation for apps that write their logs to stdout
WEBSITE=https://github.com/metwork-framework/log_proxy
LICENSE=BSD
ARCHIVE_FILE=$(NAME)-$(VERSION).$(EXTENSION)

all:: $(PREFIX)/bin/log_proxy

$(PREFIX)/bin/log_proxy: Makefile Makefile.mk sources
	rm -Rf build ; mkdir build
	cd build && ../../../_download_helper.sh $(ARCHIVE_FILE) ../sources $(CHECKTYPE) $(CHECKSUM)
	cd build && ../../../_uncompress_helper.sh $(ARCHIVE_FILE) $(EXTENSION)
	cd build/$(NAME)-$(VERSION) && make PREFIX=$(PREFIX) FORCE_RPATH=$(PREFIX)/lib
	cd build/$(NAME)-$(VERSION) && make PREFIX=$(PREFIX) install
