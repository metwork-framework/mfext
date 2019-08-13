.PHONY: before after install

include ../adm/root.mk

export PYTHON=/usr/bin/python

NAME=mfutil_c
VERSION=0.0.4
EXTENSION=tar.gz
CHECKTYPE=MD5
CHECKSUM=85db5852f975f1b3a0ea92dd25a0397d
DESCRIPTION=\
very low level C library/utilities
WEBSITE=https://github.com/metwork-framework/mfutil_c
LICENSE=BSD
ARCHIVE_FILE=$(NAME)-$(VERSION).$(EXTENSION)

all: $(MFEXT_HOME)/bin/_field_prepend

build/$(NAME)-$(VERSION)/Makefile:
	rm -Rf build ; mkdir build
	cd build && ../../layers/_download_helper.sh $(ARCHIVE_FILE) ../sources $(CHECKTYPE) $(CHECKSUM)
	cd build && ../../layers/_uncompress_helper.sh $(ARCHIVE_FILE) $(EXTENSION)

$(MFEXT_HOME)/bin/_field_prepend: build/$(NAME)-$(VERSION)/Makefile
	cd build/$(NAME)-$(VERSION) && make PREFIX=$(MFEXT_HOME) FORCE_RPATH=$(MFEXT_HOME)/lib
	cd build/$(NAME)-$(VERSION) && make PREFIX=$(MFEXT_HOME) install

$(MFEXT_HOME)/share/metwork_packages/%.yaml:
	@mkdir -p $(MFEXT_HOME)/share/metwork_packages
	rm -f $@
	touch $@
	echo "name: '$(NAME)'" >>$@
	echo "version: '$(VERSION)'" >>$@
	echo "extension: '$(EXTENSION)'" >>$@
	echo "checktype: 'none'" >>$@
	echo "checksum: 'none'" >>$@
	echo -n "description: '" >>$@
	echo -n "$(DESCRIPTION)" |sed "s/'/ /g" >>$@
	echo "'" >>$@
	echo "website: '$(WEBSITE)'" >>$@
	echo "license: '$(LICENSE)'" >>$@
	if test -s sources; then echo "sources: ">>$@; cat sources |sed 's/^/    - url: /' >>$@; fi
	if test -s patches; then echo "patches: ">>$@; cat patches |sed 's/^/    - filename: /' >>$@; fi

clean:
	rm -Rf build
