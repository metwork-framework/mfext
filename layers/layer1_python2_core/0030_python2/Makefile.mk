include ../../../adm/root.mk
include ../../package.mk

export NAME=Python
export VERSION=2.7.16
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=30157d85a2c0479c09ea2cbe61f2aaf5
DESCRIPTION=\
Python is an interpreted, object-oriented, high-level programming language.
WEBSITE=http://python.org/
LICENSE=Python

all:: $(PREFIX)/bin/python $(PREFIX)/share/python2_version $(PREFIX)/share/python2_short_version
$(PREFIX)/bin/python:
	make --file=../../Makefile.standard EXTRACFLAGS="-I$(PREFIX)/../core/include -I$(PREFIX)/../tcltk/include" EXTRALDFLAGS="-L$(PREFIX)/../core/lib -L$(PREFIX)/../../lib -L$(PREFIX)/../tcltk/lib" OPTIONS='--enable-shared --with-system-ffi --with-tcltk-includes="-I$(PREFIX)/../tcltk/include" --with-tcltk-libs="-L$(PREFIX)/../tcltk/lib -ltcl8.6 -ltk8.6"' download uncompress configure build install

$(PREFIX)/share/python2_version:
	if ! test -d $(PREFIX)/share; then mkdir -p $(PREFIX)/share; fi
	python2 --version 2>&1 |awk '{print $$2;}' >$@

$(PREFIX)/share/python2_short_version: $(PREFIX)/share/python2_version
	cat $< |awk -F '.' '{print $$1"."$$2;}' >$@
