include ../../../adm/root.mk
include ../bootstrap.mk

all:
	_download_helper.sh build/dtreetrawl.tar.gz sources MD5 36088a5ac80de534a5434eb74500f537
	cd build && _uncompress_helper.sh dtreetrawl.tar.gz tar.gz
	cd build/dtreetrawl-master20190715 && patch -p1 <../../dtreetrawl_rpath.patch
	cd build/dtreetrawl-master20190715 && make && cp -f dtreetrawl $(PREFIX)/bin/

clean:
	rm -Rf build
