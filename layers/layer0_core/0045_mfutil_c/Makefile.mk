include ../../../adm/root.mk
include ../../package.mk

export NAME=mfutil_c
export VERSION=0.0.7
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=a6019d14a7589fb43c3ef4229ad8ac07
DESCRIPTION=\
very low level C library/utilities
WEBSITE=https://github.com/metwork-framework/mfutil_c
LICENSE=BSD
ARCHIVE_FILE=$(NAME)-$(VERSION).$(EXTENSION)

all:: $(PREFIX)/bin/_field_prepend

$(PREFIX)/bin/_field_prepend: Makefile Makefile.mk sources
	$(MAKE) --file=../../Makefile.standard download uncompress
	cd build/$(NAME)-$(VERSION) && make PREFIX=$(PREFIX) FORCE_RPATH=$(PREFIX)/lib
	cd build/$(NAME)-$(VERSION) && make PREFIX=$(PREFIX) install
