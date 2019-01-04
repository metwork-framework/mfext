include ../../../adm/root.mk
include ../../package.mk

export NAME=Python
export VERSION=3.5.6
export EXTENSION=tgz
export CHECKTYPE=MD5
export CHECKSUM=99a7e803633a627b264a42ce976d8c19
DESCRIPTION=\
PYTHON3 est un langage de script orienté objet
WEBSITE=http://python.org/
LICENSE=Python

all:: $(PREFIX)/bin/python $(PREFIX)/share/python3_version $(PREFIX)/share/python3_short_version
$(PREFIX)/bin/python:
	make --file=../../Makefile.standard EXTRACFLAGS="-I$(PREFIX)/../core/include" EXTRALDFLAGS="-I$(PREFIX)/../core/lib" OPTIONS="--enable-shared --disable-static --enable-loadable-sqlite-extensions" download uncompress configure build install
	cd $(PREFIX)/bin && ln -s python3 python

$(PREFIX)/share/python3_version:
	if ! test -d $(PREFIX)/share; then mkdir -p $(PREFIX)/share; fi
	python3 --version 2>&1 |awk '{print $$2;}' >$@

$(PREFIX)/share/python3_short_version: $(PREFIX)/share/python3_version
	cat $< |awk -F '.' '{print $$1"."$$2;}' >$@
