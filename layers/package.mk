include $(MFEXT_HOME)/share/core_layer.mk

.SECONDEXPANSION:
all:: $(PREFIX)/share/metwork_packages/$$(NAME).yaml

clean::
	rm -Rf build

download::
	if test -f sources; then $(MAKE) --file=../../Makefile.standard ARCHIVE_TARGET=../../download_archive/$(NAME)-$(VERSION).$(EXTENSION) download; fi

$(PREFIX)/share/metwork_packages/%.yaml:
	@mkdir -p $(PREFIX)/share/metwork_packages
	rm -f $@
	touch $@
	echo "name: '$(NAME)'" >>$@
	echo "version: '$(VERSION)'" >>$@
	echo "extension: '$(EXTENSION)'" >>$@
	echo "checktype: '$(CHECKTYPE)'" >>$@
	echo "checksum: '$(CHECKSUM)'" >>$@
	echo -n "description: '" >>$@
	echo -n "$(DESCRIPTION)" |sed "s/'/ /g" >>$@
	echo "'" >>$@
	echo "website: '$(WEBSITE)'" >>$@
	echo "license: '$(LICENSE)'" >>$@
	if test -s sources; then echo "sources: ">>$@; cat sources |sed 's/^/    - url: /' >>$@; fi
	if test -s patches; then echo "patches: ">>$@; cat patches |sed 's/^/    - filename: /' >>$@; fi
