include ../../../adm/root.mk
include ../bootstrap.mk

all:
	_download_helper.sh build/mfutil_c.tar.gz sources MD5 85db5852f975f1b3a0ea92dd25a0397d
	cd build && _uncompress_helper.sh mfutil_c.tar.gz tar.gz
	cd build/mfutil_c-0.0.4/src && make PREFIX=$(PREFIX) FORCE_RPATH="'"'$$$$ORIGIN/../lib'"'" && cp -f _field_prepend _field_remove $(PREFIX)/bin/ && cp -f libmfutil.so $(PREFIX)/lib/

clean:
	rm -Rf build
