include ../../../adm/root.mk
include ../../package.mk

export NAME=Python
export VERSION=3.11.10
export EXTENSION=tar.xz
export CHECKTYPE=MD5
export CHECKSUM=af59e243df4c7019f941ae51891c10bc
DESCRIPTION=\
Python is an interpreted, object-oriented, high-level programming language.
WEBSITE=http://python.org/
LICENSE=Python

all:: $(PREFIX)/bin/python $(PREFIX)/share/python3_version $(PREFIX)/share/python3_short_version $(PREFIX)/bin/pip
$(PREFIX)/bin/python:
	make --file=../../Makefile.standard EXTRACFLAGS="-I$(PREFIX)/../core/include" EXTRALDFLAGS="-L$(PREFIX)/../core/lib" OPTIONS='--enable-shared --enable-loadable-sqlite-extensions --without-ensurepip' download uncompress configure build install
	cd $(PREFIX)/bin && ln -s python3 python
	rm -Rf $(PREFIX)/lib/python$(PYTHON3_SHORT_VERSION)/test

$(PREFIX)/share/python3_version:
	if ! test -d $(PREFIX)/share; then mkdir -p $(PREFIX)/share; fi
	python3 --version 2>&1 |awk '{print $$2;}' >$@

$(PREFIX)/share/python3_short_version: $(PREFIX)/share/python3_version
	cat $< |awk -F '.' '{print $$1"."$$2;}' >$@

$(PREFIX)/bin/pip:
        # Install built-in pip and setuptools (they will be upgraded later)
	python -m ensurepip --upgrade --default-pip
