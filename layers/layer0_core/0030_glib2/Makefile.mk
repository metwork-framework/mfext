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

all:: $(PREFIX)/lib/libglib-2.0.so $(PREFIX)/share/metwork_packages/glib.yaml

build/$(NAME)-$(VERSION)/configure:
	rm -Rf build ; mkdir build
	cd build && ../../../_download_helper.sh $(ARCHIVE_FILE) ../sources $(CHECKTYPE) $(CHECKSUM)
	cd build && ../../../_uncompress_helper.sh $(ARCHIVE_FILE) $(EXTENSION)

export PYTHON=/usr/bin/python3

$(PREFIX)/lib/libglib-2.0.so:
	$(MAKE) build/$(NAME)-$(VERSION)/configure
	cd build/$(NAME)-$(VERSION) && ./configure --prefix=$(PREFIX) --enable-shared --disable-static --disable-man --disable-gtk-doc --disable-gtk-doc-html --disable-libmount && make && make install
	rm -Rf $(PREFIX)/share/gtk-doc
	grep -r python $(PREFIX)/bin
	for fic in `grep -rl python3 $(PREFIX)/bin`; do cat $$fic | sed 's|/usr/bin/python3|zzzz/opt/python3_core/bin/python3|g' > $$fic.new; cat $$fic.new | sed "s|zzzz|$(PREFIX)|g" > $$fic; rm $$fic.new; done
	grep -r python $(PREFIX)/bin

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
