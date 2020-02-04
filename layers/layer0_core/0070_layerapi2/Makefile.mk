include ../../../adm/root.mk
include ../../package.mk

export NAME=layerapi2
export VERSION=0.0.4
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=bac4855a66cb5422b3a94a876d475ced
DESCRIPTION=\
layerapi2 lib
WEBSITE=https://github.com/metwork-framework/layerapi2
LICENSE=BSD

all:: $(PREFIX)/bin/layer_wrapper $(PREFIX)/bin/bootstrap_layer.sh

$(PREFIX)/bin/bootstrap_layer.sh: bootstrap_layer.sh
	cp -f $< $@
	chmod +x $@

$(PREFIX)/bin/layer_wrapper: Makefile Makefile.mk sources
	rm -Rf build ; mkdir build
	$(MAKE) --file=../../Makefile.standard PREFIX=$(PREFIX) download uncompress
	cd build/$(NAME)-$(VERSION) && make PREFIX=$(PREFIX) FORCE_RPATH=$(PREFIX)/lib
	cd build/$(NAME)-$(VERSION) && make PREFIX=$(PREFIX) install
