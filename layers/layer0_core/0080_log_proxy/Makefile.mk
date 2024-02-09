include ../../../adm/root.mk
include ../../package.mk

export NAME=log_proxy
export VERSION=0.7.1
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=bdb729ce7a37e26aa5932b03e43c6e67
DESCRIPTION=\
log_proxy is a tiny C utility for log rotation for apps that write their logs to stdout/stderr
WEBSITE=https://github.com/metwork-framework/log_proxy
LICENSE=BSD

all:: $(PREFIX)/bin/log_proxy

$(PREFIX)/bin/log_proxy: Makefile Makefile.mk sources
	rm -Rf build ; mkdir build
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress
	cd build/$(NAME)-$(VERSION) && make PREFIX=$(PREFIX) FORCE_RPATH=$(PREFIX)/lib
	cd build/$(NAME)-$(VERSION) && make PREFIX=$(PREFIX) install
