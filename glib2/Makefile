.PHONY: before after install

include ../adm/root.mk


NAME=glib
VERSION=2.56.4
EXTENSION=tar.xz
CHECKTYPE=MD5
CHECKSUM=17c3dca43d99a4882384f1a7b530b80b
DESCRIPTION=\
GLib provides the core application building blocks for libraries and applications written in C.
WEBSITE=https://developer.gnome.org/glib/
LICENSE=LGPL
ARCHIVE_FILE=$(NAME)-$(VERSION).$(EXTENSION)
TMPINSTALL=$(SRC_DIR)/glib2/build/tmpinstall
CACHEHASH:=$(shell ./cache_hash.sh)
SHELL := /bin/bash

PYTHON_VERSION = `python -c 'import sys; version=sys.version_info[:3]; print("{0}.{1}.{2}".format(*version))' | cut -d"." -f1-2`

all: $(MFEXT_HOME)/lib/libglib-2.0.so $(MFEXT_HOME)/share/metwork_packages/glib.yaml

build/$(NAME)-$(VERSION)/configure:
	rm -Rf build ; mkdir build
	cd build && ../../layers/_download_helper.sh $(ARCHIVE_FILE) ../sources $(CHECKTYPE) $(CHECKSUM)
	cd build && ../../layers/_uncompress_helper.sh $(ARCHIVE_FILE) $(EXTENSION)

$(MFEXT_HOME)/lib/libglib-2.0.so:
	$(MAKE) before
	if ! test -f $@; then $(MAKE) install after; fi

before:
	if test "$(CACHEHASH)" != "null"; then if test -f /buildcache/glib2_$(CACHEHASH).tar.gz; then echo "using glib cache"; cp -f /buildcache/glib2_$(CACHEHASH).tar.gz $(MFEXT_HOME)/; cd $(MFEXT_HOME) ; zcat glib2_$(CACHEHASH).tar.gz |tar xf - ; rm -f glib2_$(CACHEHASH).tar.gz; fi; fi

ifeq ($(shell expr $(PYTHON_VERSION) \< "2.8" ), 1)

export PYTHON=/opt/rh/python27/root/usr/bin/python

install: build/$(NAME)-$(VERSION)/configure
	LD_LIBRARY_PATH=/opt/rh/python27/root/usr/lib64/:$(LD_LIBRARY_PATH) && export LD_LIBRARY_PATH && cd build/$(NAME)-$(VERSION) && scl enable python27 './configure --prefix=$(MFEXT_HOME) --enable-shared --disable-static --disable-man --disable-gtk-doc --disable-gtk-doc-html --disable-libmount' && rm -Rf $(TMPINSTALL) && mkdir $(TMPINSTALL) && make DESTDIR=$(TMPINSTALL) && make DESTDIR=$(TMPINSTALL) install
	rm -Rf $(TMPINSTALL)$(MFEXT_HOME)/share/gtk-doc
	cp -Rf $(TMPINSTALL)$(MFEXT_HOME)/* $(MFEXT_HOME)/

else

export PYTHON=/usr/bin/python

install: build/$(NAME)-$(VERSION)/configure
	cd build/$(NAME)-$(VERSION) && ./configure --prefix=$(MFEXT_HOME) --enable-shared --disable-static --disable-man --disable-gtk-doc --disable-gtk-doc-html --without-python && rm -Rf $(TMPINSTALL) && mkdir $(TMPINSTALL) && make DESTDIR=$(TMPINSTALL) && make DESTDIR=$(TMPINSTALL) install
	rm -Rf $(TMPINSTALL)$(MFEXT_HOME)/share/gtk-doc
	cp -Rf $(TMPINSTALL)$(MFEXT_HOME)/* $(MFEXT_HOME)/

endif

after:
	if test "$(CACHEHASH)" != "null"; then if ! test -f /buildcache/glib2_$(CACHEHASH).tar.gz; then echo "building glib cache"; cd $(TMPINSTALL)$(MFEXT_HOME) ; tar -cf glib2_$(CACHEHASH).tar . ; gzip -f glib2_$(CACHEHASH).tar ; cp -f glib2_$(CACHEHASH).tar.gz /buildcache/; fi; fi

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
