include ../../../adm/root.mk
include ../bootstrap.mk

all:
	mkdir -p build/root/$(PREFIX)
	_download_helper.sh build/pcre.tar.gz sources MD5 ff7b4bb14e355f04885cf18ff4125c98
	cd build && _uncompress_helper.sh pcre.tar.gz tar.gz
	cd build/pcre-8.36 && ./configure --prefix=$(PREFIX) --enable-shared --disable-static --enable-unicode-properties && make && make DESTDIR=$(PWD)/build/root install
	rm -Rf $(PWD)/build/root/$(PREFIX)/share
	cp -Rf $(PWD)/build/root/$(PREFIX)/* $(PREFIX)/

clean:
	rm -Rf build
