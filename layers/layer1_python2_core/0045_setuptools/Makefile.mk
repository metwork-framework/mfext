include ../../../adm/root.mk
include ../../package.mk

export NAME=setuptools
export VERSION=38.2.4
export EXTENSION=tar.gz
export CHECKTYPE=MD5
export CHECKSUM=a317d98b091f6c53a905e1b7dcf7d7d1
DESCRIPTION=\
PYTHON_SETUPTOOLS est un outil pour gérer des packages Python
WEBSITE=https://pypi.python.org/pypi/setuptools
LICENSE=Python

all:: $(PREFIX)/bin/easy_install
$(PREFIX)/bin/easy_install:
	$(MAKE) --file=../../Makefile.standard download uncompress
	cd build/$(NAME)-$(VERSION) && python2 bootstrap.py
	$(MAKE) --file=../../Makefile.standard python2build python2install
