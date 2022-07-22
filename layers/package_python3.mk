include $(MFEXT_HOME)/share/core_layer.mk

LAYER_SITE_PACKAGES=$(LAYER_HOME)/lib/python$(PYTHON3_SHORT_VERSION)/site-packages
LAYER_SITE_REQUIREMENTS=$(LAYER_SITE_PACKAGES)/requirements3.txt

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
	echo $(NAME)'=='$(VERSION) > requirements3.txt
	if ! test -d $(LAYER_SITE_PACKAGES); then mkdir -p $(LAYER_SITE_PACKAGES); fi
	if test -f $(LAYER_SITE_REQUIREMENTS); then cat $(LAYER_SITE_REQUIREMENTS) requirements3.txt |sort |uniq  >$(LAYER_SITE_REQUIREMENTS).tmp; mv $(LAYER_SITE_REQUIREMENTS).tmp $(LAYER_SITE_REQUIREMENTS); else cat requirements3.txt |sort |uniq >$(LAYER_SITE_REQUIREMENTS) ;fi
	rm requirements3.txt
