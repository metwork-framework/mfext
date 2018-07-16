include ../../../adm/root.mk
include ../../package.mk

export NAME=Python
export VERSION=2.7.9
export EXTENSION=tgz
export CHECKTYPE=MD5
export CHECKSUM=5eebcaa0030dc4061156d3429657fb83
DESCRIPTION=\
PYTHON est un langage de script orienté objet
WEBSITE=http://python.org/
LICENSE=Python

all:: $(PREFIX)/bin/python $(PREFIX)/share/python2_version $(PREFIX)/share/python2_short_version
$(PREFIX)/bin/python:
	make --file=../../Makefile.standard OPTIONS="--enable-shared --disable-static" download uncompress configure build install

$(PREFIX)/share/python2_version:
	if ! test -d $(PREFIX)/share; then mkdir -p $(PREFIX)/share; fi
	python2 --version 2>&1 |awk '{print $$2;}' >$@

$(PREFIX)/share/python2_short_version: $(PREFIX)/share/python2_version
	cat $< |awk -F '.' '{print $$1"."$$2;}' >$@
