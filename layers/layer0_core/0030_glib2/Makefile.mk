include ../../../adm/root.mk
include ../../package.mk

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

all:: $(PREFIX)/lib/libglib-2.0.so $(PREFIX)/share/metwork_packages/glib.yaml

build/$(NAME)-$(VERSION)/configure:
	rm -Rf build ; mkdir build
	cd build && ../../../_download_helper.sh $(ARCHIVE_FILE) ../sources $(CHECKTYPE) $(CHECKSUM)
	cd build && ../../../_uncompress_helper.sh $(ARCHIVE_FILE) $(EXTENSION)

ifeq ($(shell expr $(PYTHON_VERSION) \< "3.5" ), 1)

export PYTHON=/opt/rh/rh-python35/root/usr/bin/python

$(PREFIX)/lib/libglib-2.0.so: Makefile Makefile.mk sources
	$(MAKE) build/$(NAME)-$(VERSION)/configure
	LD_LIBRARY_PATH=/opt/rh/rh-python35/root/usr/lib64/:$(LD_LIBRARY_PATH) && export LD_LIBRARY_PATH && cd build/$(NAME)-$(VERSION) && scl enable rh-python35 './configure --prefix=$(PREFIX) --enable-shared --disable-static --disable-man --disable-gtk-doc --disable-gtk-doc-html --disable-libmount' && make && make install
	rm -Rf $(PREFIX)/share/gtk-doc
	for fic in `grep -rl rh-python35 $(PREFIX)/bin`; do cat $$fic | sed 's|/opt/rh/rh-python35/root/usr/bin/python|zzzz/opt/python3_core/bin/python3|g' > $$fic.new; cat $$fic.new | sed "s|zzzz|$(PREFIX)|g" > $$fic; rm $$fic.new; done

else

export PYTHON=/usr/bin/python

$(PREFIX)/lib/libglib-2.0.so:
	$(MAKE) build/$(NAME)-$(VERSION)/configure
	cd build/$(NAME)-$(VERSION) && ./configure --prefix=$(PREFIX) --enable-shared --disable-static --disable-man --disable-gtk-doc --disable-gtk-doc-html --without-python && make && make install
	rm -Rf $(PREFIX)/share/gtk-doc

endif

$(PREFIX)/share/metwork_packages/%.yaml:
	@mkdir -p $(PREFIX)/share/metwork_packages
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
