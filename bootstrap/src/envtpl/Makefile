include ../../../adm/root.mk
include ../bootstrap.mk

all:
	mkdir -p $(PREFIX)/opt/portable_envtpl
	_download_helper.sh build/portable_envtpl.tar.gz sources MD5 60c0cb15707eff13ac575ac473f5ebe8
	cd build && _uncompress_helper.sh portable_envtpl.tar.gz tar.gz
	cd build/portable_envtpl/ && cp -Rf * $(PREFIX)/opt/portable_envtpl/
	cp penvtpl $(PREFIX)/bin/

clean:
	rm -Rf build
