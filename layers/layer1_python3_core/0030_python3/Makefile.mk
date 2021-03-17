include ../../../adm/root.mk
include ../../package.mk

export NAME=Python
export VERSION=3.7.10
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=9e34914bc804ab2e7d955b49c5e1e391
DESCRIPTION=\
Python is an interpreted, object-oriented, high-level programming language.
WEBSITE=http://python.org/
LICENSE=Python

all:: $(PREFIX)/bin/python $(PREFIX)/share/python3_version $(PREFIX)/share/python3_short_version
$(PREFIX)/bin/python:
	make --file=../../Makefile.standard EXTRACFLAGS="-I$(PREFIX)/../core/include -I$(PREFIX)/../tcltk/include" EXTRALDFLAGS="-L$(PREFIX)/../core/lib -L$(PREFIX)/../tcltk/lib" OPTIONS='--enable-shared --enable-loadable-sqlite-extensions --without-ensurepip --with-system-ffi -with-tcltk-includes="-I$(PREFIX)/../tcltk/include" --with-tcltk-libs="-L$(PREFIX)/../tcltk/lib -ltcl8.6 -ltk8.6"' download uncompress configure build install
	cd $(PREFIX)/bin && ln -s python3 python
	rm -Rf $(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/test

$(PREFIX)/share/python3_version:
	if ! test -d $(PREFIX)/share; then mkdir -p $(PREFIX)/share; fi
	python3 --version 2>&1 |awk '{print $$2;}' >$@

$(PREFIX)/share/python3_short_version: $(PREFIX)/share/python3_version
	cat $< |awk -F '.' '{print $$1"."$$2;}' >$@
