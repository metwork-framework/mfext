include ../../../adm/root.mk
include ../../package.mk

export NAME=log_proxy
export VERSION=0.7.3
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=f59cda49e3c4bd21efa22de7499508f0
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
