include ../../../adm/root.mk
include ../bootstrap.mk

all:
	mkdir -p build/root/$(PREFIX)
	_download_helper.sh build/glib2.tar.xz sources MD5 9023ca0ef1b34ada7e7d811158e4cdf3
	cd build && _uncompress_helper.sh glib2.tar.xz tar.xz
	cd build/glib-2.40.2 && ./configure --prefix=$(PREFIX) --with-pcre=system --enable-shared --disable-static --disable-man --disable-gtk-doc --disable-gtk-doc-html && make && make DESTDIR=$(PWD)/build/root install
	rm -Rf $(PWD)/build/root/$(PREFIX)/share
	cp -Rf $(PWD)/build/root/$(PREFIX)/* $(PREFIX)/

clean:
	rm -Rf build
