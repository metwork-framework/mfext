include ../../../adm/root.mk
include ../../package.mk

export NAME=mfutil_c
export VERSION=0.0.5
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=1d23cec0baca95eee98a57156935401b
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
