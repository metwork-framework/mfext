.PHONY: before after install

include ../adm/root.mk
include ../adm/subdir_root.mk

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
SHELL := /bin/bash

PYTHON_VERSION = `python -c 'import sys; version=sys.version_info[:3]; print("{0}.{1}.{2}".format(*version))' | cut -d"." -f1-2`

all:: $(MFEXT_HOME)/lib/libglib-2.0.so $(MFEXT_HOME)/share/metwork_packages/glib.yaml

build/$(NAME)-$(VERSION)/configure:
	rm -Rf build ; mkdir build
	cd build && ../../layers/_download_helper.sh $(ARCHIVE_FILE) ../sources $(CHECKTYPE) $(CHECKSUM)
	cd build && ../../layers/_uncompress_helper.sh $(ARCHIVE_FILE) $(EXTENSION)

$(MFEXT_HOME)/lib/libglib-2.0.so: Makefile sources

	@$(MAKE) -s before
	@$(MAKE) -s cache$(MFEXT_HOME)/lib/libglib-2.0.so
	cd cache$(MFEXT_HOME) && cp -Rf * $(MFEXT_HOME)/
	@$(MAKE) -s after

before:
	_cache_logic_before.sh glib2 . $(PREFIX) root@mfext

after:
	_cache_logic_after.sh . $(PREFIX)

ifeq ($(shell expr $(PYTHON_VERSION) \< "3.5" ), 1)

export PYTHON=/opt/rh/rh-python35/root/usr/bin/python

cache$(MFEXT_HOME)/lib/libglib-2.0.so:
	$(MAKE) build/$(NAME)-$(VERSION)/configure
	LD_LIBRARY_PATH=/opt/rh/rh-python35/root/usr/lib64/:$(LD_LIBRARY_PATH) && export LD_LIBRARY_PATH && cd build/$(NAME)-$(VERSION) && scl enable rh-python35 './configure --prefix=$(MFEXT_HOME) --enable-shared --disable-static --disable-man --disable-gtk-doc --disable-gtk-doc-html --disable-libmount' && make DESTDIR="$(shell pwd)/cache" && make DESTDIR="$(shell pwd)/cache" install
	rm -Rf cache$(MFEXT_HOME)/share/gtk-doc
	for fic in `grep -rl rh-python35 cache$(MFEXT_HOME)/bin`; do cat $$fic | sed 's|/opt/rh/rh-python35/root/usr/bin/python|zzzz/opt/python3_core/bin/python3|g' > $$fic.new; cat $$fic.new | sed "s|zzzz|$(MFEXT_HOME)|g" > $$fic; rm $$fic.new; done

else

export PYTHON=/usr/bin/python

cache$(MFEXT_HOME)/lib/libglib-2.0.so:
	$(MAKE) build/$(NAME)-$(VERSION)/configure
	rm -Rf cache
	mkdir -p cache
	cd build/$(NAME)-$(VERSION) && ./configure --prefix=$(MFEXT_HOME) --enable-shared --disable-static --disable-man --disable-gtk-doc --disable-gtk-doc-html --without-python && make DESTDIR="$(shell pwd)/cache" && make DESTDIR="$(shell pwd)/cache" install
	rm -Rf cache$(MFEXT_HOME)/share/gtk-doc

endif

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

clean::
	rm -Rf build
	rm -Rf cache
